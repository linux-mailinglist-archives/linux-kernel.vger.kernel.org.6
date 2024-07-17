Return-Path: <linux-kernel+bounces-254750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 839AA933735
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8149F1C22A97
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 06:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C955014F6C;
	Wed, 17 Jul 2024 06:36:37 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27D9125DE
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 06:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721198197; cv=none; b=ft4JjL0KaqZae9Ax6O3YCzbR30PWm1RLkWVSyf34rLhzR3VecOwKNzzh+rag/ltrxcRAaFNLU5mCvMXEtEEvDw8OlncN+QiwPNQMdC49s3VeYIvHc2fC+6uw782xP2GMcahXuC8dpzC3s8/RQRYEpTN9BhflHRU9EK5SHt0y5T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721198197; c=relaxed/simple;
	bh=PVmra4eCTii2LfLUG4acQiwY4f7eEMtUlcw485O/OqA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qe3ToX/VmPgOKf1DoQui52cluBT+OeAHSwgtIhsxtAdvji1vaxFRdUzkNGCZwmi5Xj2s879f/JC2KoKPt6F0UUQVz3ce54pHS7j7ywhtpiSBwoLJtMfJdNQvOjo288C/4VGed4gUdGkxlFhPQVj2EvNNd0o2402M6wB1v35WxuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f66b3d69a8so84427439f.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 23:36:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721198195; x=1721802995;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u2xvd8kIWPqR//G/hju22dN6ozbX00cW5QpnPXTjt2Y=;
        b=rvhe6M/p5oSBZ+AinnV/o+4AriTaGe4WPSYP+fOWzpi/KHlPtjuRhRXIyxz1u5T7H2
         7tTuJDitUdOLN8zo82I40kkSangDNclkF3WfQHzj+MsP8k8ZVpiNDbl0KPitDz/GVRYe
         oZ5iK4rxtnlQ4dhZ7HqQo6rN5+GfMymBHrMTwFrAdd9X6QstuWAWvJ8fc7Rza3LLpj6b
         VKwYM9G/OSJMClJX9QdD2JWwpBWjVcxGgl6BKkgVR+NS44J4xt5TxNoStqY+xFu6JeLg
         +grltjN53puZ2PfMLOlipaHV14KJmolN7m+QIIzOL5uwdRinqjT8poUg5e2loNq5ic41
         LrzQ==
X-Gm-Message-State: AOJu0Yw2QaPQ5uZLPMJBAX3Fuk3ibW6iV2OQJ2a+wj0DKQs1hUPpXCKz
	o8x5XmerW8dtAoANmcgabLOohNqWdcHz3j6dDfMv20g4bzFA6n+14Nm4VgO7/bOdI7gGvjN0pZn
	oFDmEFDOt4fLPeFLjWO7AsHpedEb0VuwHAXrT1ugVZr/77TEvoihTCP0=
X-Google-Smtp-Source: AGHT+IFHatxCRBnJqAvgHjtfDKY4IV06yaD6lJS6IxxZK+0K3Kv5oqZ7sbwsv4Z2wBs+2o2a9ctcqSMigTqMQdimYROE3iZRane2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:210d:b0:4b9:ad20:51f7 with SMTP id
 8926c6da1cb9f-4c2158baademr16968173.1.1721198195085; Tue, 16 Jul 2024
 23:36:35 -0700 (PDT)
Date: Tue, 16 Jul 2024 23:36:35 -0700
In-Reply-To: <000000000000be9914061763f17a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000001a5f1061d6bafaf@google.com>
Subject: Re: [syzbot] possible fix
From: syzbot <syzbot+5b6ed16da1077f45bc8e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: possible fix
Author: almaz.alexandrovich@paragon-software.com

#syz test: https://github.com/Paragon-Software-Group/linux-ntfs3.git 
562d060bed6637fbc3bc22802a0a0c5b00e12a38







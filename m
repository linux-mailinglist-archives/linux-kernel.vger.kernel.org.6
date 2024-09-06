Return-Path: <linux-kernel+bounces-318684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E9B96F1A2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CEC0289671
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959781C9EC7;
	Fri,  6 Sep 2024 10:36:41 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D949A1C86F1
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 10:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725619001; cv=none; b=sZKHd+MpIyAvwDb5Btxx3l1D3WfZ8NxNBkzxOERKEGhNMEL0f02TKzLI5NhpsrIuMvRR59l3JvatG42oAmJKLhGXfZ/VXwyvJEZ0Tiin5gwZRfunrC8ooFg0WO1L+zoJZQxmQEsRbbaVP0ORJUxSVB7NXAD4X8BrGqwDXDCPTDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725619001; c=relaxed/simple;
	bh=s65PSgmqAMIU4+T3c3amlPqy3ktRbbbJE1h0TOpO63Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=V/cdb/Y2b0Bmle0Fs82QWqMauaGw0ZObrofctfYfKxdBmRiiZd5uUD6CVjshDgRw8IwEq5DKPw2fpWaz4Uou1Q7qw1p6KYKMfRJ2TUrPuW+BzInU9ABGHX5A8x9iI1XzUPt39rCAb6DBc4hCfrw9AKM28EKOkhU26mKlrzpbaPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82a338f090eso487229339f.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 03:36:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725618999; x=1726223799;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZV8vWXHXmsEtRiA89coPFPoEl2W0AMI3Q/1NGqgZRfc=;
        b=pJAV80J0SFCl0zMUpAi+PxYS4DGvtNOp+FcMRbzkl55n/vitLFoGQ/Wa5VvI25FLCr
         5fb0onB+C3+CuUyoIL8i8NlGdJokLR5euqnrvCbHUluag/kOQQefcAInzKN3n1LUQhjC
         z8wd/G61d+HK9urB3TWey+NU0DJvbnQQ4dBqmQx/c48HCNqsHlyrbMYyQr3GZAP18w17
         BLAooFpjETuJawPyngxziPRSKnrj/NT9PRdQeBg5XcULhugm6plF+kLAYbTnxFlapT77
         pwbnfXbM7glQNTiS871xu/5CjQyKVdKcbw7j9hKt2a2+B4fBVcuGrx6DpKhqI01Jp008
         QEUg==
X-Gm-Message-State: AOJu0Ywh3aUNnq/+9UxJBztZl+r9ncjvdjko7Xnq4EBQIRSfGRIDMThR
	Dhl4V7+4sWJGrVzTMooCDx3k+fKB+KB5i4pZdNz6wJ8PkK70VEiSccX7h1QeBXgySjiMcDbOoUp
	a8/Wr5KZf4hbWYw5jg0uE+eLwuPk981cGDdrQrBFWgRJc2ETWFPSYVhs=
X-Google-Smtp-Source: AGHT+IElY4qmDbOew/1Tfm8pL8MU/DD9z8JWFaaWEl3HBxOVf7xdg1xWQ17NTnx8L17FOEM5ujmuUMLtiuVMYhn1Qsbr6z2sqkLi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2a:b0:3a0:4620:1339 with SMTP id
 e9e14a558f8ab-3a04f10fba4mr1311685ab.5.1725618999021; Fri, 06 Sep 2024
 03:36:39 -0700 (PDT)
Date: Fri, 06 Sep 2024 03:36:39 -0700
In-Reply-To: <000000000000a256df05e39a74e7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000745ed8062170fb28@google.com>
Subject: Re: [syzbot] 
From: syzbot <syzbot+8d19062486784d15dda9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: nogikh@google.com

#syz invalid

Repro now triggers a different kind of problem


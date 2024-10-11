Return-Path: <linux-kernel+bounces-361154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9CB99A45B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D280285033
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EE9216A05;
	Fri, 11 Oct 2024 13:04:34 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A931A20B1F3
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 13:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728651874; cv=none; b=IazSQCgiSyVYXkI+hWzQB2h5eOFqXHDJDoJhiA3AfIBOQ9KY7CSGT+r2g/KZ6VLS097iEjwduHZ8MPAerajRzfOzmh7jkiL220p+0Pn6nDpe5QKPjTTnxbgb02/04svFxZORmg7WAk8rapOUJ9CvVnaOm6Jgz0/Ht8oHxn3k//4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728651874; c=relaxed/simple;
	bh=tAGG1y1LZZik2eJM5cMct9MC7ETH4zYakVcDsfNUZAY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oOBy2sOcpm1PcIp9p9JSSH+QhrUgyvVrTwcKpsQrAS0BJELS6ZyH8XQLb9gdFf0EeJzd0q9DmbrTuyHwGDsC+LN4wQgyHtEGlh+P5+vRlGicHiY0LPNYRuaHIDxLeerepIZ4uyxlPDFiGGw9qVsFvN8WjNCARAj7A3QyBQOh1CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-832160abde4so210656839f.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 06:04:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728651872; x=1729256672;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tAGG1y1LZZik2eJM5cMct9MC7ETH4zYakVcDsfNUZAY=;
        b=SmzCjNyV6p1TxEAvbhJuEZKAXITLTdsRzfdt48uvKA1GZdLEIxzY3fkg0BR1UlAbB3
         kMMX+U0OgBgozVWXHVX44cN/EcvMRljsyE/AIWetuWzMxxy/3AHItNl8gA02wFxqT826
         Odl/k5xKEtrU1ySdtFpo0nUghe/aWjj6bxrdG7YVdrNOdAj6wXpczUvt/F1yrUR+KvCF
         z0VUdCftLZwxTequiONyZyZvCkMYXlgC5V9gOfpB+grNOcvRMyTYkhBunXwGTOVydDKk
         HuSMDrmZbO/jSa9GXGNFzrT8D1mz1vslcyDE4NabPEnm/Wba68f3FMNPEtQGBkWM5smr
         Z1og==
X-Gm-Message-State: AOJu0Yycio/dU6cBrm8cMfB0SFMCIUd82JQKKo6V/YY0Dd8s2KYiSEEp
	Uwginw1rO3LelQMz44LuNMJZM/Vq3TgvMydAACVrOHlcSZ0SBzxl4zYvEYm/ZGYFbYvf/1fkllu
	stgjU697UOt7CFCeFmOiAxt4pUnzLlwnpL4R+NT/Vu2qc9uB0KoBBOB8=
X-Google-Smtp-Source: AGHT+IEDx619pCuRf7yl2lZYTtqWXuvPFz1aTgh8h0ieB37gQ+gMsdi/eMiJXfe7U0wobxoUyCIBeLcCn82bnRA2S1gH3pS4Leg4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c06:b0:3a2:762b:faf0 with SMTP id
 e9e14a558f8ab-3a3b58ca80fmr13918535ab.11.1728651871871; Fri, 11 Oct 2024
 06:04:31 -0700 (PDT)
Date: Fri, 11 Oct 2024 06:04:31 -0700
In-Reply-To: <67014df7.050a0220.49194.04c0.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6709225f.050a0220.4cbc0.0008.GAE@google.com>
Subject: Re: [syzbot] KMSAN: uninit-value in __exfat_get_dentry_set
From: syzbot <syzbot+01218003be74b5e1213a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KMSAN: uninit-value in __exfat_get_dentry_set
Author: sarvesh20123@gmail.com

#syz test


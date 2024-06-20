Return-Path: <linux-kernel+bounces-222065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C55890FC60
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 07:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E2C41C20BEB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 05:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492F038385;
	Thu, 20 Jun 2024 05:56:18 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866E52BAE1
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 05:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718862977; cv=none; b=pLLflhULiTkyu/yUe1vkipF/15enqb0zHf9CdVLGMHNnu1Tdgal9cq2ZF1ypw6KOubEKDE14HfOCvhE2wLxigHNZ2CwPWUdcIpk6i2NhAmvsaiXWRalfH3W0lbz+YuBcWZg/pGSHbmgb+uyoiPOtovRa8mVmyXOhxs9oxFY4Ucg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718862977; c=relaxed/simple;
	bh=9r8d9ndPxn3J1ztheXxVMlbxp3fdypGeLkE8sHDLIsI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=BGUllqu5Mo7EaIFCHAUXk4eWKRKYBFvDzJymqs/lhSNAB+vl+4Dj9CXwiXbGbHgCdZW1iL/fIQguezSJy1HPYX3ULQ+ld5PXfBy+QGiKb7YhBiDmZS8GSRpdSfAtAknkg7QvtqcB1znaXhvIczu9tkEo94HavkEB4uUfG6rlkGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7eb21854dcdso54568639f.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 22:56:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718862975; x=1719467775;
        h=content-transfer-encoding:cc:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9r8d9ndPxn3J1ztheXxVMlbxp3fdypGeLkE8sHDLIsI=;
        b=PnzBhiDm0SINqNszgqB+oUFhlGuqdmruyHc5Bx5IfK1ZPJgItqDAHdvh9scSpeI7pY
         TMu4D+ANN0mSxNfuwR1ZAsgWbfJAq65KPlC9r4Es8+XaIDApSzaUxC8e5/uH2gHHnJHH
         iyoKtM0JhtigvvWzJo7HvBbT9UNKzK9jJrKrEjjBhp3+kdktPDTcY5BHO+beHhZlqsH/
         wz1dqBnug+dsH8kPIFXA/x9vNRXJrioKC39nnr25RNbGq7m/wK8n8UHuxv7FZV4Jv9A/
         +3voZyab01Ht4JXtpTYfHOCdEm/100sGIZgco7RgbcnNsGEx4/0ln1EIPWG7DKUQh6EM
         JieA==
X-Forwarded-Encrypted: i=1; AJvYcCUKCmcpfmte3R2HejG7bfhRpGZq6RJshSZUFQnXMjnYe5o/rGoKsx1cJ8Lc77g55XgimI4JVGOX/IPPrOevUWFvvKbO4uWLrIrkg+B8
X-Gm-Message-State: AOJu0Yzio1o8HQfk0k6pG8tEELMGVPOIlNrjlgpd/n3WiANR4t07wcU4
	75rQ4FIT1U026naFvlN5+8uKH+YLvJMt4gdLnEOS57gfutbGA/yxBMf13TcCjJXOLSchbZp7MRB
	TYCiDwU4yic6Hy/bRlXO6kS5SXsciXAy1aup5MY5NNTGprl42B+4e4yE=
X-Google-Smtp-Source: AGHT+IGETsi2EgM/qq/tIkWT1rCi8wSEmLZpR/m8npYl13qLKQSXVr1SBqsUR2zYETHh9c3Wfa/7GIj8hLcBt+Q6uvGgLjekG7PR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8507:b0:4b9:30ba:85be with SMTP id
 8926c6da1cb9f-4b99b745db0mr138192173.2.1718862975674; Wed, 19 Jun 2024
 22:56:15 -0700 (PDT)
Date: Wed, 19 Jun 2024 22:56:15 -0700
In-Reply-To: <PN2PR01MB489118B0901BB49F1880F759FCC82@PN2PR01MB4891.INDPRD01.PROD.OUTLOOK.COM>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000153ba0061b4bf998@google.com>
Subject: Re: KMSAN: uninit-value in sock_hash_delete_elem
From: syzbot <syzbot+c33bff5d5da1391df027@syzkaller.appspotmail.com>
To: wojciech.gladysz@infogain.com
Cc: wojciech.gladysz@infogain.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> #syz test: https://linux.googlesource.com/linux/kernel/git/torvalds/linux=
 0daa6e5ed1ccdeb65e07d4884961a8bb288a0f54
> #syz test: https://linux.googlesource.com/linux/kernel/git/torvalds/linux
> The information in this email is confidential and may be legally privileg=
ed. It is intended solely for the addressee and access to it by anyone else=
 is unauthorized. If you are not the intended recipient, any disclosure, co=
pying, distribution or any action taken or omitted to be taken based on it,=
 is strictly prohibited and may be unlawful.

Command #2:
want either no args or 2 args (repo, branch), got 59



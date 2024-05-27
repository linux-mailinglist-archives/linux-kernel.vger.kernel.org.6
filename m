Return-Path: <linux-kernel+bounces-190331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A98558CFCFB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB7CE1C2194A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319BF13AA3C;
	Mon, 27 May 2024 09:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="UWXDMtyd"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3734A13A897
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 09:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716802397; cv=none; b=qPoLDPukUWRAdUj9QA9sjhEPbJ/6/AUI+iHBjrJDt07yToIOWExuZpFJJaAYUV/TWVcJbD8Qh9mO8uustYfRHdDGJ2Y9QTIAfy874QTMaYHl0cDXbMx6pN5TL24zaISZ7dn8UKxjfoWQyYY5O2NcZx3HQPoRpoV9dorad77Gpmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716802397; c=relaxed/simple;
	bh=Tj542Ql3NJjfsqzKkHdQSa2YLnrfQwlEirm8q8wFYEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fF85hYC1OS18cV5mM8bnPciy08nJKzhzJQeuGkff5RTCMZEoxBOIAKtMYK3ZCgz7A6GmQ2fj8e9S45ce4RfPEyZQ7dfIcXBto/VTxPtkwiQDsUcvELV4S97t8SaG8RNi2C82OMLCann6oATKm345lEPUnXYf49/rgjWW6fM/9QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=UWXDMtyd; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-529644ec0ebso3944640e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 02:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1716802393; x=1717407193; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kyqsMalQEV+9l0Conlo3kxuFIzX2TPTLRyUlJoVzZhE=;
        b=UWXDMtydM3KmhAobcJxrDXLIBvaOkx8VT4IBboAfv/LLFbEcvqIZq1ok+vNsyOHPFB
         H+OkaLHEy57JMz2OvdwyHwZNnGImY3+8/9tu1G9o59omWSSIl4HuegAHA9sit+CZZQtf
         C/y6AuBzR9gB8nf8XFe6h1ir3ljzcRqjOzt0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716802393; x=1717407193;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kyqsMalQEV+9l0Conlo3kxuFIzX2TPTLRyUlJoVzZhE=;
        b=ROf/+QPk9R4P7Skxtf7GXvSQ+R3an8j/hnANXFSi7Hn7HLG+gZGxQh6PpVmgQ/cmaG
         qR+obFY/Vkuw6eCSVvXNn+B4RKoeG/G4OUpd9K8bEdYzGhsz9v8W4S947pwenXfqg+y5
         K0/SBjCPRAvWHZ8Gj93IoXTq3e63uLVj9cqxaIahKa4REfy/ecIVWILbrNJ/ZOsA2KQY
         vNPqTED4NRzSb9j62a0A7XwpdbJqeX/wxZuTg95SUS+eNw3NMy98eE8cy5enU0wTxjAN
         MZacBBsdjLrzkpxJAIXC3HoC3oE+zC+DG8xIWRJZ2HnXNCFW+H8RdXfaC4kenPPPBd4L
         zmfw==
X-Forwarded-Encrypted: i=1; AJvYcCUMTyNzhelrCJL0a1Uv0k0ZB2+SN7j+IgQhTj6nrFK3Vhrck2yVMnnHoOYkE+U1ebhL00eqPogHxunH1qtx9IRCCj9J0vJGqxLoH8Su
X-Gm-Message-State: AOJu0Yxkm4r4jXDOkDaxT6ElNwVp2z3KzP+ZIfhAzUVe37/BBgQio9KI
	8Ie+QV1feZHZtG8YVD7xyL5lATZE/Z7OuCBgZho9lDEVBIdS5OzRDlWJ3lHzcOPe/+ovwiQzF9y
	alo/7cG9P1mFgEA49tl1+pSRnzIAN+EvvL6sk+w==
X-Google-Smtp-Source: AGHT+IEi8JlRPopO8DJkGromiP7EPtR3oTQlYMDIwWpliTsfbENXpGmoToZgmtMb2h5j7tLDJVTyjz3Cs8MdoaCtfhs=
X-Received: by 2002:a05:6512:acc:b0:523:97bc:ea88 with SMTP id
 2adb3069b0e04-5296736b9d8mr8970330e87.51.1716802393007; Mon, 27 May 2024
 02:33:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000abc6c5061969e3a5@google.com>
In-Reply-To: <000000000000abc6c5061969e3a5@google.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 27 May 2024 11:33:01 +0200
Message-ID: <CAJfpegutd_duD=jFoFFG1GY4pvmBOSBmiO6A1uGXJj8_3vxYWg@mail.gmail.com>
Subject: Re: [syzbot] [overlayfs?] possible deadlock in seq_read_iter (4)
To: syzbot <syzbot+fcdd1f09adf0e00f70b1@syzkaller.appspotmail.com>
Cc: amir73il@gmail.com, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

#syz dup  possible deadlock in kernfs_seq_start


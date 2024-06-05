Return-Path: <linux-kernel+bounces-202232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D98E28FC9AB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09FC91C223B9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CCB192B7B;
	Wed,  5 Jun 2024 11:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="MChRTUQk"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149961922F7
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 11:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717585521; cv=none; b=HRSTf6EzbP22djQsjF1+AaKpJFHeDsMzGNrGlRn25QG5O/8T2kPre5vi0E30CQVqdRRa5ynfeqvIhPru31uo075ntJQ5JWAD7zXv+g2lktZt5OTPSFYXKHTFl/atVfnZMa26bR2pHd7W3hjDVT4T+nWIHF8wlaMNqTIbuKegiK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717585521; c=relaxed/simple;
	bh=Tj542Ql3NJjfsqzKkHdQSa2YLnrfQwlEirm8q8wFYEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GWVKNtARaamykNlLMu409pxa6aoPXqWxxrRyH5yMPYjrnoygBBR4L20nJDLJQBbZxpVaBoh+tn2sAJebTFiwyVOf1eKvPkTxK5fRnXHoAeGZCJe3iRsugKwHa7O2hvCHUBIDYgaik3TI9hniEPMKXnmTORVQM9cGXokYPnObS0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=MChRTUQk; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52b9af7a01bso4098924e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 04:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1717585517; x=1718190317; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kyqsMalQEV+9l0Conlo3kxuFIzX2TPTLRyUlJoVzZhE=;
        b=MChRTUQka+ScVsKxC4bU3D1yoCTNQfDwawIb6AYBRwQz9iL8WHyPmSGxmJQhsitdvc
         bkWo+STv54y8dzv4oppwYB2ssbLVP+/JocoEtGz8w0fInsR37s2VAdkkWpbHVLOhGt31
         uqCWbsDVkydO+so9xPJXeT8RdMrEKY+pGZ/AQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717585517; x=1718190317;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kyqsMalQEV+9l0Conlo3kxuFIzX2TPTLRyUlJoVzZhE=;
        b=bmTOswkrc4ZTY9DeWoD1/TllWEClem1HdABVCAoA8NLGyYIMY+hLMYS9Pw4zFKI5Mp
         MOV7/CmltCjTdrbauWJ/JH3W5ZUh5x5/MaGENge3o+x/w8cF3arm/bB3F/LxA+5pAQX8
         qdsIEL5IXV4ey//5oPoD7HO74sNaWXL0z0OMWuo9Bh+sb/Dl0KVyx+ER4oHQYLsEyFgM
         ZEibf0+YZSKaPWuTpqjsqevExAoXNhilPaKZuDQJ+1Pbtwu7SjUuYnk85O7Ql+dm2dNt
         u6Ct5gtNt5u6INfo7ShNXlc+CYWEw9QfM3UGcbiUX0Kze5MNzK353GRhHUJVHYPpzwaR
         dW7w==
X-Forwarded-Encrypted: i=1; AJvYcCVuqW6TMPNjrVizt9tvU0/85AgZ1A9lHukKinxGvxnB1RycYDizrRrAXPHV7wz5QKDRC3sBCBk2P7NUlK3K91GpuLbpc2a2B0Ox1B36
X-Gm-Message-State: AOJu0YxqBjxk2MeNZrlMCHTydkSu87j7pfus+CwSyXjWGg4fsCeNJt7H
	Ke5eEbzAHoG5ivXMSKF83HxRrHwv9hIDE3LhPF0PzUW6sZ6myzbR4Mhh9e42jGUVxpeIOqUD3qu
	UpBRcROWoqFRkhARJRj+z0wvqC4htwdar2dJVCw==
X-Google-Smtp-Source: AGHT+IHF1jsrlJq9KSyXvJxuUgLBjkY9uATcMo/+IhftCPJlKni4Cg/lx7edyCsWko7aivNpEEUAT/3Ib2sKhIAftKg=
X-Received: by 2002:a05:6512:e99:b0:51d:3f07:c93c with SMTP id
 2adb3069b0e04-52bab4b80c7mr1806663e87.3.1717585516840; Wed, 05 Jun 2024
 04:05:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000065b2f6061a14ecde@google.com>
In-Reply-To: <00000000000065b2f6061a14ecde@google.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 5 Jun 2024 13:05:05 +0200
Message-ID: <CAJfpegveMOTa8jV7fTWARuOU-_xXddrY7G1M3DJeoYNZOJ6hMg@mail.gmail.com>
Subject: Re: [syzbot] [overlayfs?] possible deadlock in iter_file_splice_write (4)
To: syzbot <syzbot+5ce16f43e888965f009d@syzkaller.appspotmail.com>
Cc: amir73il@gmail.com, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

#syz dup  possible deadlock in kernfs_seq_start


Return-Path: <linux-kernel+bounces-441171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BC49ECA91
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DAAA2875AD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC041A840C;
	Wed, 11 Dec 2024 10:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fireburn-co-uk.20230601.gappssmtp.com header.i=@fireburn-co-uk.20230601.gappssmtp.com header.b="Ye19dIQG"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD985239BC4
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 10:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733914029; cv=none; b=Oyn/4w1YluJrm9nKwQL6v6K74w4wKz3FPo5/Ce3Mzkg9PVc3gujIsEj+qOTOk3WeEmIVlYzl9nOmt4s03G5Xn/3pmrZHZjt9Ghyc/wHMFjByu6oLp7+l0YxEFp2FZuVMowACQMi4r5+BVej8u3ZQnGpy1Ee+kwZVvHdKU5O0jdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733914029; c=relaxed/simple;
	bh=nKjcDcJB4jySgsM+5Bv4lh0SR2eEjEafuclhhXKVV5Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ch8et0R4r3/49kDh8f3ciIT6u2mMfubZYNaApwJNqtYZYmZoUUTa1sjRwHdWwhrYYB8pXpnvyrArOIN+HnYLfm4ljpcY/eZeidSQFiJeihlLCZqNSiPcEhJeT9UjNaeU8fUXtE+wc8TjXKc6wVsHPVihxIqynP/ixkN7WZ0EjaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk; spf=none smtp.mailfrom=fireburn.co.uk; dkim=pass (2048-bit key) header.d=fireburn-co-uk.20230601.gappssmtp.com header.i=@fireburn-co-uk.20230601.gappssmtp.com header.b=Ye19dIQG; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fireburn.co.uk
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-801986033f9so749665a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 02:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20230601.gappssmtp.com; s=20230601; t=1733914026; x=1734518826; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nKjcDcJB4jySgsM+5Bv4lh0SR2eEjEafuclhhXKVV5Y=;
        b=Ye19dIQG393nM8RDbMcfNqLa6sVAhNCHanOC9iIAZc5ijxmQVYWlidQ+3rHpdrnunY
         YAmwC/bFvZ9ptLCznDGH6/fxKXHr/r4nGQloBvEGH5OQ/Ny6BHlNLTMdHYK29lHe3mzq
         bjYLsjZxUtyG3E+h5ucNeULAujS7m9p1hpUBJL2P5IH2m8T8i/oQPyNUaeyeKqqSYFVu
         E2h23nDJveeVvMWTqdBNturic5O0Fx1AgT/yOOSDG0Nf1ve/modFcg32hFUTpI92vxUi
         cWVIZVHzcAqCR/TGDIUkkYPnxtbulSmHh9g13Yyv7gaBy8XIK9kBDnzH4kTgaHD2E8mf
         2kXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733914026; x=1734518826;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nKjcDcJB4jySgsM+5Bv4lh0SR2eEjEafuclhhXKVV5Y=;
        b=H/dWU4YO+DNAcfjv10QzNoiJCuTCTzUa1+w4tjmuqEnVMwYdEVBGBTMF4PSk4jlsvB
         Efe6e4jthwKrKuI6j4xDnHBVBtq9zbRJurBjF5VnjdaNH/sUfqlN3HNZznmAwgpdiGKv
         s6LYcBEsE2cGSPtS7dLN+FT0d++bgGcXaBV8O7EEpdADdKHJqUECwY/eg8UR+aR5za1a
         ZZbvBkV4MdczC0+RWBT8XQqIe/rvSRzrAWn/cqFjY6lP6C/OrvjTr89PiSpsOlXpsVYl
         OaIjHlsEcsPlRYeC++0WSo+Y0KTM3oMbIfjXAg3uEVIlfqSEDf8KDAhkpASdZCqpG+2Y
         n0gQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmO3V0WGplBM0p1jVs2/j2ukX+h10sG1CzSYWL+KBvu15vJvJK968vZa/v5oiT6i4ADOuUGnyaWCUvzlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxCqkFAua8kRYj/ZxTpfRkUhcgXFw74bdolrGsvFC38jwnzEOp
	EUkJXeaKgDDn4XAgkryXpavVLDqqhVF+2c8fafaDceYs4A8xb5qkMNkQRpAQe6ko4Ewd6PZPkuB
	Zs4h13y/1ntWT5eRnWn1F94dhDRjSTy45E6bk
X-Gm-Gg: ASbGncvvAsT6YtoLVppdCfPtL1APpb/LSNfwFhOldx/XvquabXplsEcdbf8bcUTvKVs
	2LdhYe046PZQ9DhZJZOf6iRrIBahoODHyjF/ukOr1ukN3d5Z/WyydspeKN1F8HuZkGm2IgQ==
X-Google-Smtp-Source: AGHT+IEfc10uei7wMAJXp3wNIDyhS3tTRIVNGgwU+Xml++f4NrLtyZznzfdG3yC/KG2xrJEx7qUX2s8l+mP+Egmyjxk=
X-Received: by 2002:a17:90b:1b47:b0:2ee:5bc9:75b5 with SMTP id
 98e67ed59e1d1-2f127f8debbmr3550949a91.4.1733914026227; Wed, 11 Dec 2024
 02:47:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mike Lothian <mike@fireburn.co.uk>
Date: Wed, 11 Dec 2024 10:46:55 +0000
Message-ID: <CAHbf0-FQCNkOg4F=cjOCGsD0QzxrSj99ssYaH+9A=GnSn+PqrQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: replace deprecated strncpy with strscpy
To: justinstitt@google.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-hardening@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev, martin.lau@linux.dev, 
	morbo@google.com, Nathan Chancellor <nathan@kernel.org>, ndesaulniers@google.com, 
	sdf@google.com, song@kernel.org, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi

I'm not sure if it was this patch or an older one but I'm seeing the
following warning when compiling/linking with Clang 19.1.5

vmlinux.o: warning: objtool: ___bpf_prog_run+0x44: sibling call from
callable instruction

Cheers

Mike


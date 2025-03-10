Return-Path: <linux-kernel+bounces-554112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2A0A5931A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDCE0188F46E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA2F2253A5;
	Mon, 10 Mar 2025 11:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEhkx2Ic"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744A02236F6;
	Mon, 10 Mar 2025 11:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741607652; cv=none; b=Aqg3Cg5zxajCFpOQ4Z7ZUVDvnSQFwJ5xG5Iq/6VR8ux44GlvoSNQtmn2HE7vZPgJbva95i8pW+ZF4CxIH3VJUCyra+HPg2n9hm+kfGS3kWuSZ2Uqz7wBDM5mgIQzD1+bTwFTUVYciUg51GYiTWV2kG53EH5xuapWGm3QTB3MNYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741607652; c=relaxed/simple;
	bh=WQAyS+wvSGevd5h6mHVr6QduwOkpHnCnqNsLAbkqwYA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ehawGsdCwruSt4EM1F2Fz+bsZsV6EoB13QQPbVevsf0QSDXx4KVelCKxsw7tMLiCvhf8gLICmnsDOgbP2z4MgFhqUkAhSkFXz28Y3cztIvdYTG7DJgiqVyBY5KW1w3tqNSHbYsk714EmiAazeiMVDUH1DXnEJbD2AxO8C7rTYZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEhkx2Ic; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ff784dc055so5077696a91.1;
        Mon, 10 Mar 2025 04:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741607651; x=1742212451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZh5UHX0Yh9smQvLpBtmhqIcELJRC6+5nK4g8sWfxdQ=;
        b=iEhkx2Ic3ITxx5eb28oHg5ICCz3FFvLB3ygtP1iiQ0dBuzo4SVRtJzOtQ45ae6Jued
         D6cV4gn/cqPWn0AJAvm3Ils+OqffOqkw/ssZEBXhy2/zfy5IxJ8Q8ObjM8unr5OXx3Hm
         +1FMEBzIyVPY8wUkwJn1R/0mIuO+FTz1lQJ+XPOEJZl7kJYz83pJgJ7lDRMEaWCDyrkX
         dL/JE2A5Okml9st7NDJuwrvGcShUb48aoAKsyA2tiiYMeF+RiuNzYOuMKiS6qfWyi7Bb
         hEaeduf7kNAJELwjM4Y8SLQrdr9ilJ2hFf8kRi+MH849LJy5k9EGypsNWz770hJF15Wt
         9NfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741607651; x=1742212451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZh5UHX0Yh9smQvLpBtmhqIcELJRC6+5nK4g8sWfxdQ=;
        b=mvQcJ4XKI0ZDTy1wd0fCD0H23TIEb2QO4etZRPt/0WnALWoC0favU2VnQWlVn01LRW
         Qf2E64e3cYZeoy+EAZ/Fzk++qF47I6mQsqW0txSNJKJAMX4I2J3tkt6JuX6lPEHnZH7L
         eK2rh+IeRssSR5Ij+2/kWXHLPCXzumGH+tRlZAsOa2nUuTXh8GKbcUL9/2oIV2lA89RC
         G6iQfyBfeiyfdVIiaVICaDaHWsYQQWuuFVgV1gmRnuWr5oc7Rv5dNm6Y4RQGcznbguGY
         RDyFi+oogx4U107ugjV36tVnDtNbtKDGUQ/76D/npb78/rNfLVAeDdVoX/Vpr8PMRUD9
         L/eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNcsRkxGfUqWV2sLvv1SpII/G2nBjY2Z03VQ46Yemjn3wFlrRO18T7VX9DAbL4P3pSbTYsy6EPCYVOTvU=@vger.kernel.org, AJvYcCVHxIbRa52XDc4RR0/1tBVwPrBMo+Mt3b3kPAIjdT8FmzTuYItBut3zIzRY2k58HhHcU3gwh4n2CN+3vDYAv7s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw75xHZht44IwqdBseovXZcR/7YVtQvcCTjU2tC6pXFJbsncobc
	ToXyox8Q8KYEGvQvJW51Vj5gvmbZmKjxmrnbmhA7r8jtvBs9j6sf
X-Gm-Gg: ASbGncvb4AAZsUrBNR67iFP67Fj0muxURrooem6Nw8uOd/Y5kXIKUtP0mJdVT3X5rxe
	0rRXyz5jXYIvkx7MKbQz57eKLdYEw2mmXN6pRYx87vPg2pZuztukl1Mv4nyFwgeyHwd2VL1G/JZ
	yd5RI+ZRetF3dqML+/4Vlv/Ce8UMiR0fxy+MmcAMo8noGwNd8kZfKTOkfGx6eyWfZDhyz6QkOqD
	kuGSiC6fBwqt1qbSTtor8LRnnT1YBs1AkGZ4+znAczp2LrDQ3MDcfeSJqZevwghPOWk47J+VO/R
	R0KJk+Ld48guG/OiU6wwoGeNii5m7+Lunu0g12VBSIUiUx3Rx0ISR3cnk7TCSzs=
X-Google-Smtp-Source: AGHT+IGOrbeqtV8cfu0Kg9gzfwrryMLkxz2zTMBjj6MQlo9KZf8HbYsCypifsqFi+/SStYmRrgSKaQ==
X-Received: by 2002:a17:90a:ec87:b0:2f5:88bb:118 with SMTP id 98e67ed59e1d1-2ff7cef6771mr17940024a91.22.1741607650521;
        Mon, 10 Mar 2025 04:54:10 -0700 (PDT)
Received: from linuxsimoes.. ([187.120.156.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e7ffe18sm9678820a91.31.2025.03.10.04.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 04:54:10 -0700 (PDT)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: miguel.ojeda.sandonis@gmail.com
Cc: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	apw@canonical.com,
	arnd@arndb.de,
	aswinunni01@gmail.com,
	axboe@kernel.dk,
	benno.lossin@proton.me,
	bhelgaas@google.com,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	charmitro@posteo.net,
	dakr@kernel.org,
	dwaipayanray1@gmail.com,
	ethan.twardy@gmail.com,
	fujita.tomonori@gmail.com,
	gary@garyguo.net,
	gregkh@linuxfoundation.org,
	joe@perches.com,
	linux-kernel@vger.kernel.org,
	lukas.bulwahn@gmail.com,
	ojeda@kernel.org,
	pbonzini@redhat.com,
	rust-for-linux@vger.kernel.org,
	tmgross@umich.edu,
	trintaeoitogc@gmail.com,
	walmeida@microsoft.com
Subject: Re: [PATCH V7 1/2] rust: module: change author to an array
Date: Mon, 10 Mar 2025 08:53:58 -0300
Message-Id: <20250310115358.854053-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CANiq72m1NW7UVYD8+bt2bYivb++pR+7_2P9NooAcLX4zjKWkHQ@mail.gmail.com>
References: <CANiq72m1NW7UVYD8+bt2bYivb++pR+7_2P9NooAcLX4zjKWkHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:
> Please also avoid sending new versions for very small tweaks or very
> frequently, since it gets confusing, e.g. I had in my queue to reply
> to this message, which is v7 but v9 is already in the list... :)
> 
> Generally, you should wait a week, or at least a couple days, between
> revisions (there are exceptions, of course, but this is not an urgent
> series).
Hm, ok. I will wait more in the next time.

Thanks,
Guilherme


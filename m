Return-Path: <linux-kernel+bounces-526265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE3EA3FC64
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6749A3BA4C4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C5E214A85;
	Fri, 21 Feb 2025 16:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVfNoyIU"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57794214A7D;
	Fri, 21 Feb 2025 16:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740156822; cv=none; b=KRJ4PPjnF/0Mdv95EPMHyjYHPJEhp+WVlfz3xZ3j0lYwIlZGJvhpb14VV7CqQn5/JFZdTGsrtn7/goHJ0MTImbdkwtx21lb33nsRaad5Uh0GstIAYk35T1p/Zr7qKwzfW3uvdXTmZ9076baQceK5Y3Rabdlat00jbfGWFJU7YjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740156822; c=relaxed/simple;
	bh=RNR8mEUOnIVJUD2/SSlodw5N9H3r9pd1pvfEYexodzw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WOnVrqhOL86sFrKzHJYx6msGX9j8M51+ERtiR9LPm+Ok+bvMusTJGO9Fahb1lSzPgJjNTw/7krUrsKp40+Xyf0WZv50iQ5N6j+dpydk4mL9U/mbIcFYxvTwvK34Ekn8Ps+3lw2p596zqGo1u+sJbK1/5W4fTKPisiv1AIECxrNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVfNoyIU; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22114b800f7so46546375ad.2;
        Fri, 21 Feb 2025 08:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740156820; x=1740761620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/zBaSuV0apxI2fraq701Zzbl3a70mLl15KTuoHr3ig=;
        b=jVfNoyIUf/4dRmDNGEkwd67K/BFu+DYb3qTW7V2KJh1yNhjxNAIaLeymHIeWvWAEX/
         ShD0iZ+NEmNopiQnsFkKPpvZx0L282DwE4jUa66RWwHt9K5vOI2TfKZ8R90kdhfaCWMX
         XReBYH9gwcaNlQPJ6QOl7cU+rp4CvV2++oEhRJIghthWydD/vDwDaA1dhKu2UPI7X13x
         iYBnwATwBZOam6kr3n3fHFb0rFFLpPQ/uhdvdks2YmfStVKfRZ3+Kngleu6YhR3e2No4
         8yKhF0vUj+izUogZnA8Z2Pr/5fJ8VjXXH8a+lcjq5VDM0PXqxD5OQsmk0XUObCdDOoQR
         PwhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740156820; x=1740761620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j/zBaSuV0apxI2fraq701Zzbl3a70mLl15KTuoHr3ig=;
        b=JwS3esup63nQE06ioddP3lnMLfQsqmk05rkCpCjR5+qVCvlvWq4Av3brc2FnsIccaL
         L7IRA62S1C/m9xMIphebBakPbIWyH3evKdG3OJlAzOBoArxyEqkyK7WQVhTO64iy+9Ks
         ov3WydWGfJ/dYojTj869eSb8V4hxoSaOstYxVwQ3Inkmj+kWWrQUbILcdePQrwUQ77oF
         P2TUmhTAhHihhcJPAS2v984D2rJsiI/Ab+mINghLXzx3N+P/HxcjYuIzQNcrfFIdaLPY
         NykR2YSyjOZXcYjZmFvl/qSYBOiLDa7xG7r+s+7Y9IIBY1qLPSEF77DCvQIRYPn9Ba4g
         T8BQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOSsZBaoh12CctpzGzdK5AWpEDPuKZedmewlZ6YQCnGtrA9/H1bin1PyGMqjAdRwPcwVwBwsRViRIHaPVcHYQ=@vger.kernel.org, AJvYcCXa2Cagoz12f0ZYk6A620B1u6x3Wv/St9KEa6UXvzSBYLdj6gbBwTYMhlmmcbDSH26n5SDt5XQzVCs+7Z8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEH9iJZopqiB1iDZ8XKsTM4otDPexJQhBSGJyEW6sxqqcpkv++
	TxzSOBHacy714wdvTnZAc2UzdNY1sXz0+AbpjbiP7DYdiKdugiJe
X-Gm-Gg: ASbGncsGdqS8E5ZQEmGUTrUdJXN7v97QMaGvmz4tdQeAM7RIg+quXGnB8hGlfYfXeLd
	yMzZyFipLoN+tJcwCufwStofcA5+5vmrE2x2A7iCVOafJVaZbi+vPpaSl801hM9IDJJByWPmQJW
	gfWevLnfisykAmeDyy2NcRotjumAXnt+IiHf9Lf7DSTVMOSwUIAnDurNnl2QHpz5J/AAcb5FU+u
	zghqlZY2AJ6BS+v0NsyllhuBLagC+oNKXe0rm0LoLQW17kUaG/MPulGuqSKpoIbLJYQdNHo5Mx1
	bIBrDy9qaBXysNxXpxdj0iaSFKi7zjCOdQ==
X-Google-Smtp-Source: AGHT+IF2YMDyHbwTmyW38BAvJ0G7QtBOaYJTYewQDESOFgJXibuRb0b6kmUsta1MzqxBRVKAe5316A==
X-Received: by 2002:a05:6a00:3d0a:b0:730:87cf:a7cd with SMTP id d2e1a72fcca58-73426cb12bbmr7543385b3a.8.1740156820211;
        Fri, 21 Feb 2025 08:53:40 -0800 (PST)
Received: from linuxsimoes.. ([177.21.141.136])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7325b1afd0esm13525983b3a.137.2025.02.21.08.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 08:53:39 -0800 (PST)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: charmitro@posteo.net
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
Subject: Re: [PATCH V3 2/2] checkpatch: throw error for malformed arrays
Date: Fri, 21 Feb 2025 13:53:27 -0300
Message-Id: <20250221165327.5459-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <m2pljcgpek.fsf@Mac.home>
References: <m2pljcgpek.fsf@Mac.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Charalampos Mitrodimas <charmitro@posteo.net> wrote:
> Hi Guilherme,
> 
> Will this work now that the field is called "authors" and not "author"?
> I think you forgot to update the regex here.
I don't know, I make change in modules and samples, and I forget runing again
the checkpatch.
Sorry .. 
I will send a v4 

> What do you think about this instead?
> "Prefer each array element on a separate line$herevet"
For me, looks like great

Thanks,
Guilherme


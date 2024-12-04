Return-Path: <linux-kernel+bounces-431635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2479E3FC1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E205282B06
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6800C20C473;
	Wed,  4 Dec 2024 16:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Q/+2DcYx"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C7420CCC0
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 16:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733330010; cv=none; b=jj8MAkdDvEs53AUAmdDxI9I+0iVKW45thhR0O/WviTArvfYOyFWuPV7F1CJge6PqZ+V0Y6q9H5CcghGGu/KixeWgpVLpURvovjD4B1fPNEtoskmD80xg7wb9wZrE0bsz6QuzDM8R2xFwYMoZ9n5utRwsgMQ9mICPli4jUYxzgcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733330010; c=relaxed/simple;
	bh=jjpAsfnDViEPTArEMDoLsQjV/xeaagtYm84LbRevTPk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ib+LnzhrdDW8VdqQNAkHviIKSGm6t0cyDu07e3brm9wsH3akWZ4dqWfDtUImaww09DDP2Jew3XeF00Jjiv3LfKMrz/HWhqkbDjdylGBR+3vn1lDVxjHo+47bWv/JDrL6DlgbnK8UWKpcmDCBEkPxZ+HkZm7G33NxUrXDsLMYMLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Q/+2DcYx; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7253bc4d25eso24239b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 08:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733330007; x=1733934807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hb5hc3qgWT9L6cng9NISv31Ehv7llzw2Vl8uDpnsua4=;
        b=Q/+2DcYxxT6g/pM9QwL+1fSTK1kRbq1P6IgWb/Rv+dPmn7PBTZZjF3+VTyhrbLSn0H
         kv3aeHSGxOfcDPYlTwx3THE3tTAGEp9cEdccq6kfHDz/2g6lYP1jD40nb3U+5EM+NkIs
         H5prj+UuDenOoB4vMGAOvvw3ANcHudneUU+Rq74Rz2mgJovQO8vHVzMYal/RaEXcg0sA
         QpZHI79qxQBaEks5wnJYTju1CMpK5eJX3Hwug62bNLANPnKpQ9qnc/2VXiFucODz0wCN
         2NPwPwRWdVw2ElxTrtXfpCm8kJhGkG9hrhYGiJKc90tSMha3djazlEQmYr0b0IOLbvGl
         JyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733330007; x=1733934807;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hb5hc3qgWT9L6cng9NISv31Ehv7llzw2Vl8uDpnsua4=;
        b=TN0bvR0I3JWXtrhdbpI6iofhZSZ00FYV0Amp+tildaOgXe21a8hVpVrTYqs5pnXGNx
         8EhJWTIrcgkd7WcjflMf/wyeqAHQ6T89G8DzbKXIpY42T9rGybOy56v+Adj33I1nfsNp
         c6nVMUjk8/992D/WxszDwN7kGZZ2vQsNBaYnw66/PnQ5iX3NuqIC4C9AO6tbpXieTWbR
         SZJU2Gx7WApf7ESLvaU+/is+Gvc7AefwPyuPr6guQ51XTdRtX8DiqHhLiOkhqyuogYG6
         daOBJEygR4HKrpoyUoP3IlqG4tH8RsON1UgxHVBBXxdfeUbABLKQXGPR7G2149vWtQnD
         y8sA==
X-Forwarded-Encrypted: i=1; AJvYcCV+PwuT1SgrgIw1CJULH4guzDbZWTdIwBkJuPUxM7QtAjXpXsLyrKlsnPir0QBV4Qr7RpI1f0HkIGxi2H8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCC9m+xp3qct5PTS7wxtcwd7qyNRe7Y66/uFTswmROPc7j2kHu
	VpSE8zXhpmI1zGawX2ciV4+ZtdWJThEAP0PUYjQYkFpMbK1U0qEsFBNUDIYbRAA=
X-Gm-Gg: ASbGnct/ltuzgk51Bp/Vtq5vmYeMmPIFXp3UdjD219h3zK65SCo3aV3+eU+vyZGA0NF
	M6nQaA9RPbtA7UkOCWt0fNSBzi8EQFbQfnZpjunnwxVgzyEeMWKYDtutKEk9AlokM1YZ3WDcHXp
	vu7aD3Fcmry+LZv6uVigllA7A0eREWLRSL3giqgmpphl+EtzEoM3mNp/lblMX5cDY9SFzrtCXre
	Y0VfnSVybRMTusmG5GoNdqWzNlE5A==
X-Google-Smtp-Source: AGHT+IGEY5dtfqqu7yQqDHuO3mHKg1f9S+1DRwm5m5EOLxdsx+PQqoK1BhMnJkgc7n3v5DxDmYv9oQ==
X-Received: by 2002:a05:6a00:cc3:b0:725:4915:c0f with SMTP id d2e1a72fcca58-7259d6008e4mr10467b3a.11.1733330007187;
        Wed, 04 Dec 2024 08:33:27 -0800 (PST)
Received: from [127.0.0.1] ([2620:10d:c090:600::1:a7a9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254184952csm12955492b3a.185.2024.12.04.08.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 08:33:26 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 Boqun Feng <boqun.feng@gmail.com>, 
 =?utf-8?q?Beno=C3=AEt_du_Garreau?= <benoit@dugarreau.fr>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20241204-rnull_in_place-v1-1-efe3eafac9fb@dugarreau.fr>
References: <20241204-rnull_in_place-v1-1-efe3eafac9fb@dugarreau.fr>
Subject: Re: [PATCH] block: rnull: Initialize the module in place
Message-Id: <173333000587.511414.15268819552143079818.b4-ty@kernel.dk>
Date: Wed, 04 Dec 2024 09:33:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3-dev-86319


On Wed, 04 Dec 2024 09:38:39 +0100, Benoît du Garreau wrote:
> Using `InPlaceModule` avoids an allocation and an indirection.
> 
> 

Applied, thanks!

[1/1] block: rnull: Initialize the module in place
      commit: c018ec9dd144dd29b4a664bf69e486f14bb4ee87

Best regards,
-- 
Jens Axboe





Return-Path: <linux-kernel+bounces-446344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3F09F2317
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 11:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 292E416469B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 10:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F145014AD02;
	Sun, 15 Dec 2024 10:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ojkm1FkE"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0641F12DD95
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 10:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734257666; cv=none; b=aiQwztFyxM/4nHealkc55fLImXafAMC7hvgZVGCBrKbmB09g96GMrAkowjNyVbTYisnv7L1M73oBziuGBvm2Quh4yk28uKCvIKF8M4hBbyhHEG7StQSn8GWQIGrNfQYmFLBoD7CNkz9K50T3oqJCk49ZkQZ0swpflgwtu4xnqb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734257666; c=relaxed/simple;
	bh=T6I5sFPvgXQenvHGDpF7a9tvT0DreXjvECBpiuAyedk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iD4RJf6mysAZGXuCBzpMVLCplX5Vp45dhUkrTd7bbffr8FzVauKHVNTEbQIUVdiqZu/VSon26n/Ds/wXkG3XIKK99X+fCj9zb/ySS8LPVxO2CAcCttX09ymhUi23jkeeb3IAbi5vSUdmfQdYw0W88bCFSuJbSQm5GGFYz+fUbbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ojkm1FkE; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-725dac69699so2659502b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 02:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734257664; x=1734862464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xqNjjk7oEjBBCzGWGGRo1tlNVo/ASpAvWDY2FHC/tA=;
        b=Ojkm1FkEyVF4/dv4SDTgJWS1+ELYzmQDJkhLTTqkBFm06rAQx1XNv1nFUwDM82XKyQ
         M3QsL3sjMasyKp0JlJjkOGaMmS2gSjI8kxZ+DOnucwOhpf/BuAKXa60n58zMbYZrBl6z
         jbLVqxPcWc6kyZF4YC8Mm9pDHbY8L+Q3fzlWfUbrVBSSWUPGNIg/9Zhab30ARRsfAWCr
         KF8Ii0Ytb4w0jdV1BuhiXIU4WBrLZIrgAj6X9Xs5UsKleB+a3HczBJKVGxRhtK61G0oH
         VV6hOIqgssCEWY3WyHRXrg34DTcwQKXKnLeGZAV5244uDcChjOIXO3YNO/u6hk/jMxw5
         dO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734257664; x=1734862464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1xqNjjk7oEjBBCzGWGGRo1tlNVo/ASpAvWDY2FHC/tA=;
        b=o5AiKW/DrOkF1bYOEdVmi+kkz+afD6aBzfjh51wnlYWFbYZ4zc2mcWR5692Fa0SOz0
         gZyFXKQgDHZlznmG5onn8ctAy/0P0sPWcq8mGdBG0f7TM6/ixHg5Cm7uhW7YmPgqjYyS
         b0nZuCw9vMPYSWtxjR1j8UJFygkxihJs1yAEh1hP+xLcMW9iYWbnF0kdytYN3MmrYeQY
         l47MV9ijIH65gYfI3cV4UqGw9DVSEGijuQIQYb+Xg6HYksUA6ezFI3zp50FijPIDofU/
         Oz8Gr61FiUcuShmCpUo18nhdLDVumd6oKNn+7c3qhBo/NQNDh4svNIB6rRmSOA5PKmNp
         JAXA==
X-Forwarded-Encrypted: i=1; AJvYcCX9YjMfHshaLdU4rRJu23yoXv+Vj6bTTY+pvkhyKNPITA4hIiy7QrAIFNgNK8RKyMay1Khebr6CbCF8zck=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgT657oeven4QjG0Duo4gVCCdmshGdHqqJ+eJw8FZSIGtoKPdc
	h5xVjwROfVINW4f6kgo9+HZgBN9jG+HFWqf17Q7O19xB07GgU2GI
X-Gm-Gg: ASbGnctyxrkirQMCiEo99bFE+jZIcDqTXNEqC9r/vbDkZnpuDwYzj+fIyUJW5pRIPlc
	+j7NeQez0MvVYBDW1ldaUfOxyxz8RGokgrmv46dDi+1z6IDnfJlcCHH+llqbMSIV+wR3XIYqeBC
	4EVREHlD9dYBX8Vt7KjkEglZvuOWqC838Ov6wN+ianeIwVtqPgUDHWBQ5M5OlMwbHIsWizoB5Tb
	a81zUi5HzP4C8ive5lEJoYZk7k9kMkRSzE1IrgsNB9KCce3xJvWMZTuFx9u4glFakxlnkgi
X-Google-Smtp-Source: AGHT+IG+xe4V3gMOmWzfmbscJyj3mj8PuzdPQlwEW+IjcFStJ0C2iV7Qej0RE73ZtI1KNm8nn2Ugxg==
X-Received: by 2002:a05:6a20:c996:b0:1e1:a693:d623 with SMTP id adf61e73a8af0-1e1dfd917camr12694780637.25.1734257663984;
        Sun, 15 Dec 2024 02:14:23 -0800 (PST)
Received: from archlinux.. ([2405:201:e00c:517f:5e87:9cff:fe63:6000])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-72918ac5264sm2807705b3a.21.2024.12.15.02.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 02:14:23 -0800 (PST)
From: Mohammed Anees <pvmohammedanees2003@gmail.com>
To: snitzer@kernel.org
Cc: agk@redhat.com,
	dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	mpatocka@redhat.com,
	pvmohammedanees2003@gmail.com,
	zkabelac@redhat.com
Subject: Re: dm: Allow the use of escaped characters in str_field_delimit()
Date: Sun, 15 Dec 2024 15:43:33 +0530
Message-ID: <20241215101336.1456-1-pvmohammedanees2003@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <Z1hrfMRedzEJb26O@kernel.org>
References: <Z1hrfMRedzEJb26O@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> It would seem Mohammed cared enough to write the patch, but not reply
> to you with further clarification on why it needed...

I thought I had already replied to the concern, but it seems 
the message didn’t get sent, apologies for that oversight!
College academics kept me tied up, and I lost track of this,
apologies once again.

> BUT, in this instance it follows that: if lvm2 is allowing weird names
> which require escacped characters _and_ dm-init is used then dm-init
> needs to support handling them (dm-init is all about _not_ using
> normal initramfs with lvm2 in all its glory).

I completely agree with your point and am more than happy to 
provide further details or make any additional updates to 
the patch if needed, please let me know if anything else if needed. 
Thank you for your time.

Regards
Mohammed Anees


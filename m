Return-Path: <linux-kernel+bounces-195593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC2C8D4EEB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 17:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43846B27452
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 15:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B333187552;
	Thu, 30 May 2024 15:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/Oyx4wx"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496C6187545
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 15:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717082342; cv=none; b=M+iC5MESsxLKAidIHVnw6vBXEIBpaRJ0jt/HQ3I/orOi/Yf2kZGcu7/rIkJt6DD04YyTIUnCKoOOQkA+JkzC9DIBTjpLxbp7Dza97Tbp7MR7YuX9rFafWNVNvAFg/i9fkA6Upd/RSVcp3WhMCfBxnxEzRzP60rmKuQsSR0AuBLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717082342; c=relaxed/simple;
	bh=RI8icN+FXbp9Y8B3z/9KLMllFH0l0/9f/oZ7ncTMGrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZX+oWShFaHwlrdRj3bKMG5XUVBNrHRvAFgO6/9Bz5OZqZOiyQyQ5v5Gt7ABqFaQFoX3tlfJZy5DP8nS+i3+uZChq7yD19dyRxCsNAMUnlqFnJzsfvNui+taeCFA8XO08Yi21VL3ERZUCF2iUs0RCmeRtlvyyQS4et1tD0KT6lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/Oyx4wx; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52b7ebb2668so1087670e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 08:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717082339; x=1717687139; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b2xnnYdgiJxiz4X+rNxIsG3HSCy59EILqUkEtjG7IdI=;
        b=J/Oyx4wxGHKyD4jgFkgUEWfm8lOYtRGMhF/IcvEKBxN6G/FHVpRl/FdLkqLsjFhXpj
         54ty6M+AIkQ9slrCOA7PL42/mfNm4Zhk7Pb4dLeULL3ujTZN0G9F9iwcZJs10KpnUrMh
         INj6+331ssC8pdgk7zuQgaANc6A3LIXwI/afshgLO4S1u1+ziXglMy7Sda6sqaQ/SdZR
         zCSKBl8RFsvNDjE9Awpx83ewN7fWCgmKzLfPVdR81YamAvo2l/e9CAXwAbGIFikI0rnU
         kDZepC8YBO+42EQUtqCBO+ynFs4PX1/e2sG4SjEVKuLGrNIV54qCfBajurO2T84ximRV
         SFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717082339; x=1717687139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2xnnYdgiJxiz4X+rNxIsG3HSCy59EILqUkEtjG7IdI=;
        b=PGHbStr5AvxSwZKoC9pWx2G8Na1dghQ6AsnO6g6O5jcNaLT80wyq1pcakcYRxCmEL4
         FnARM2VRojJNFycKR/5LD2rmiZTHHpIpTROq71V0lWuGvqCTzJb1MMkTHzZ40J6Y04jp
         XPntmstCZKRoWU5lwDmftXv9PMdNFX6tcjanleTJz94cSGfbyFVHsxXcvnJcDbtmrRux
         GhR45aQeuYh2xYAvtJeYpW4AAlkwQWTYdNB7C+LW+qvawc9xUC/PZnhi4XpaTI2htqMZ
         2TanodOZsmNhx2m8J4vSA/pojtEqD5SSrsRlcVO1QEww3QOEjwXSubTIEeY/fIh/nucH
         qcpA==
X-Forwarded-Encrypted: i=1; AJvYcCUj19vt5z1z8t+YzGHC9lkGRoZM0BzEMh0d2PZHKXGmUcafmufa/cLj71xCYXeyPPsPHPpm7WiXXwoUVW6vnItB+D0JcK/IlztirFHJ
X-Gm-Message-State: AOJu0YwbgAgPScK6uTMW08eTUXQS0rAHLV4+RtjoIt0LuCpSbMaWYCPx
	gSvQdQJuMK+hgeQWrxTmb6c+oc7Hfm0umB9mShoYIWtagzDDfDUV
X-Google-Smtp-Source: AGHT+IEeoqTtAM1bj93m+Z02mdAebmcf39QHPPOBBDZc/q9wDu+sWsoDXYgY8CKGyK4WseoBITbq8Q==
X-Received: by 2002:ac2:5338:0:b0:525:32aa:443e with SMTP id 2adb3069b0e04-52b7d4282demr2002523e87.17.1717082339173;
        Thu, 30 May 2024 08:18:59 -0700 (PDT)
Received: from andrea ([151.76.32.59])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c93872esm834551266b.86.2024.05.30.08.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 08:18:58 -0700 (PDT)
Date: Thu, 30 May 2024 17:18:43 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Leonardo Bras <leobras@redhat.com>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -fixes v2] riscv: Fix fully ordered LR/SC xchg[8|16]()
 implementations
Message-ID: <ZliY0ytpksarswi6@andrea>
References: <20240530145546.394248-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530145546.394248-1-alexghiti@rivosinc.com>

On Thu, May 30, 2024 at 04:55:46PM +0200, Alexandre Ghiti wrote:
> The fully ordered versions of xchg[8|16]() using LR/SC lack the
> necessary memory barriers to guarantee the order.
> 
> Fix this by matching what is already implemented in the fully ordered
> versions of cmpxchg() using LR/SC.
> 
> Suggested-by: Andrea Parri <parri.andrea@gmail.com>
> Reported-by: Andrea Parri <parri.andrea@gmail.com>
> Closes: https://lore.kernel.org/linux-riscv/ZlYbupL5XgzgA0MX@andrea/T/#u
> Fixes: a8ed2b7a2c13 ("riscv/cmpxchg: Implement xchg for variables of size 1 and 2")
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Reviewed-by: Andrea Parri <parri.andrea@gmail.com>

Thanks!

  Andrea


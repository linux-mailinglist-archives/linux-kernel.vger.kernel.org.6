Return-Path: <linux-kernel+bounces-235405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E271091D4B2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 01:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8988E1F2110C
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 23:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA44F5B68F;
	Sun, 30 Jun 2024 23:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KNIG7cWV"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B74845C18
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 23:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719789199; cv=none; b=uQ4GBXyp6UM979NKchGRD3KMZCoE9W2JlsLgnTjc27nTUCAN2fpIb41ltBr3EsS2rgYc2iWceITcb5xFYaDugzv5Gir6yR/GsIF09DiAmnKqiRjP+Qa8n9Q1UDCG8DLy4jWS1F2Yp9rZBfgji6RtkZq1VETrfHsTzCOi02E3Dmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719789199; c=relaxed/simple;
	bh=2VNZ1ykXc8m4T5zpK+zJuSHgnlFS70HDVy1/fZbxJFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lTlSFV4dhA1lSVjTo5ExqGR3dfFBv4zqq2GS6/L8BYpmRUYNSLkl3RT8LmpvYJcLMJv/BNmWg9zkKjN1QuwrOz07ziTOMv1SNzP9vgidFaYhmHNaXfwbkNvV30ysSyPaYiJi6oQMQje9q1AaArzQOGEB49xpluONypWNEe1IKC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KNIG7cWV; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52ce674da85so2585680e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 16:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719789195; x=1720393995; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HJ7eVxOAFkX7TbE5q1XOO1V0zws/SUSAaeEkqcul2UU=;
        b=KNIG7cWVhXyzUkntgQw6bINRRPZGbiGbgWjCCAQ1tW2MDMLaOHTNylSZ/KiuKTl1e2
         zsD5gfbAghT07VFqB2ruyW2psA11cy7Qlu1zAm/S/g68CH3/ytTEHFq5IoDcjzPzB6m0
         Eg26miEE6GxF1Naypp8jQGcGjhriwxvEHTjSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719789195; x=1720393995;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HJ7eVxOAFkX7TbE5q1XOO1V0zws/SUSAaeEkqcul2UU=;
        b=BS5TePoMqu5nxGcq0f+nh5bF+UbIqPDtpbk8U61c3x19U4eAo/wDvSnYPMBtvAtaCg
         c35v5ysgLckhG2g2vzhmNWIE2JBc3WQtBpo2fVYHWe8hm3yl67cx/l59L0z7uDknx8Jx
         BMz8p0oGkiMZX6VeiZgR9mLPXE3SLhoxF1D82BVZNnAqp6BQKFk1JBk/6wDKwvUt2kqz
         nY3ptZpgnfOU5reVaQPsQjgesdP8uDBepP2TVIBfaAG3UVa+10SCtsaEA9JslbsPZ392
         xRYInA/oyOOQB1heUN5gGQDb2bx7GYylPl6LK9LeP675xVI38UAVS2EqLi+dWp9V6zUt
         fMUA==
X-Forwarded-Encrypted: i=1; AJvYcCX3D2HkdNCHUTLgIDHpeaclJcMtiELIWJ6xXneNktpKhIv8Ie9EtLKr9x09v3MjMunNor4KupvNiiulCY2gvdx241hrgWkvfxRKoOeh
X-Gm-Message-State: AOJu0YxPMtdAB4oefrHH1bpTHvtcyPCxkeNNgXxql6ondsYdpzj0lfNw
	0C7V7/Uv0rb67DeQgfM34b8NKscj3mFhSxhnGULmBZwoQItmGZG7TCznedOhlQ6ejKgQTk65aQw
	Sg0NAuw==
X-Google-Smtp-Source: AGHT+IEn5Z0q6wGR5QJ30YoGwJ34vhbGf6aiAubGsDnOgmI/isIdQrDwIwdmkh37vfkgTLKyY/Nx8Q==
X-Received: by 2002:a05:6512:2355:b0:52c:b09e:136d with SMTP id 2adb3069b0e04-52e8268b415mr3423107e87.32.1719789195302;
        Sun, 30 Jun 2024 16:13:15 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab2eb55sm1126672e87.214.2024.06.30.16.13.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jun 2024 16:13:14 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ec595d0acbso28499011fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 16:13:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUIiP9llfs668bqp1kfzmOE4/iHaHYRzQOFPRXeo8+HiRg+iWzEmN64tLJbTNKlG6eNUXQhzCCDDQKz4o+99bfzmrlF68XBcz6r2nGh
X-Received: by 2002:a05:6512:3e29:b0:52c:e0d3:c199 with SMTP id
 2adb3069b0e04-52e8270a85cmr3110424e87.51.1719789193916; Sun, 30 Jun 2024
 16:13:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiWEgSo2Tb_bih7mnS27zAPL+RGg_7yX4qK1f710-j-Ng@mail.gmail.com>
 <20240626151131.550535-2-torvalds@linux-foundation.org> <CAFULd4bpH7-epdnh4CGwUHhLua2GLMeLiLJok3aJ3k+fA4TPfw@mail.gmail.com>
In-Reply-To: <CAFULd4bpH7-epdnh4CGwUHhLua2GLMeLiLJok3aJ3k+fA4TPfw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 30 Jun 2024 16:12:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wixEkWESzNwzRVYjAPE+zt36h7eHzAuV3z6mwxGk4x9Cg@mail.gmail.com>
Message-ID: <CAHk-=wixEkWESzNwzRVYjAPE+zt36h7eHzAuV3z6mwxGk4x9Cg@mail.gmail.com>
Subject: Re: [PATCH v2] x86-32: fix cmpxchg8b_emu build error with clang
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Jun 2024 at 12:00, Uros Bizjak <ubizjak@gmail.com> wrote:
>
> Reviewed-and-Tested-by: Uros Bizjak <ubizjak@gmail.com>

I ended up committing this directly for rc6 as commit 769327258a14
("x86-32: fix cmpxchg8b_emu build error with clang") since nobody else
seemed to react much and it looked obvious enough.

              Linus


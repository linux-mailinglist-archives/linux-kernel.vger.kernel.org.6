Return-Path: <linux-kernel+bounces-443578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A2B9EF7F8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FFFC2871B1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD704223711;
	Thu, 12 Dec 2024 17:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4rgW3kF9"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB73222D67
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 17:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025099; cv=none; b=ThDdLyR4+pYa5i5agZ40QNWVKW+22sT9Uqhn15TRzD/DYeWYAo260LG3LqszPYXgQqAx3Gaf4RqtF8JykCiXv0NiNoQhvoenNlK+lk4srmSw/I778Vu5aOfvm5oiMCdJ4wzqa2+nULi16Hme4ve+kpApIcBhHH4+4NaTK6veH/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025099; c=relaxed/simple;
	bh=aWTVrxmG5W3tIhT6neWuRFNEJ1LBgRdw+hgIKFCMjK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lOfR3Ddd+o0aUkyB81vSOHdtjwFaqYPPR6iMuNAINwWBMAWGYtSYuq/+bT/WT9XbV2YQorGFLGK4IDw4SDw+nYGCOj1duUUOOIZ0mzVF5s1sX+SFIg6mea0eYys5spSV4y+ms0VhersFhe05mN4T3Au+EK1WamPpn5UK/kc6ZNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4rgW3kF9; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-540218726d5so887350e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 09:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734025095; x=1734629895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWTVrxmG5W3tIhT6neWuRFNEJ1LBgRdw+hgIKFCMjK8=;
        b=4rgW3kF9468wmzu5vD3JP2gqmc4PdmJAWEx2DVd80dOtBAnwJwaaxmm/DAHJO3bYIY
         dQWCVSDktLwQ7VY7erI49aRt1NVP9Nb8iMD1j9Crza7t+fvbyyFizPyhloGYOoiVmJ3c
         ovIboTYbmYkTrK0uh2L3wuTGWqPvaAuGUf+d4VhxkefASUIIvl6HFQ8lLUc5zj8c+UOQ
         ZQA9obp/zn2gqu7MkONKg9YGFMOCf9MGc75qK5wYbjo2pRCPS6QRmRYbxzz4/OdM7Ybo
         W417cELTTjvLWTl56/QqSTvb3EVIQ4+Pmk1q76lMX+90km/kwUu0PzVhXFoNnPRk/QNb
         43vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734025095; x=1734629895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aWTVrxmG5W3tIhT6neWuRFNEJ1LBgRdw+hgIKFCMjK8=;
        b=lbxMVa8M7X+kYoBZ5Hc5oUJ5BtRBZZaQUIMW3bR652dqNNZw89QO7CmkVX9mu7raCB
         2HT9bv21Ydh8ennSySBtDFRqHTWe1wogUQ0FcENNd0JUwZLW6tl9IWX2hyxMvPTrRY+f
         GoC8eAZ97MpwMkInTpnB/OtoW7tzhjPf1MzO/TPHJYnQ95N8d1ekPIeE/wcjDHSnboDs
         mHIP7pQSOZOBHMb3DRJ4CBexKkuiOc83FrMNy7VY/z029JoRITUcvJfL9dtzvUN52fmy
         Yl1D9tpIOJ4Ca/nOfDwtqfSa8uUZ9rGDuU1h2CDcxGObsbNx9ne1Fq1TeiamQZcZOb7l
         vLkA==
X-Forwarded-Encrypted: i=1; AJvYcCXWejUPmRLIHZh6D76arFNNo8SwaXMlPQ0IvOYsdNAzhWFDGOAPl/MoUkhQfpCeoSTg+l7BSjs66NUoyYs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytu/oQn4mA0BUBZN8o8i+5I76V4xXcqjTWikckr3Tm/0uQ96FG
	mQH25gQyaY8VDdPZM/irFs81xocTy9MCUVaYiJITSwHU8Pm4Ku0rb2ui8MIqCg+7HJwnASdWRtR
	B3pfC6fU2rjbbFsZ4f/JYY1HVqAW/6A1iIgLw
X-Gm-Gg: ASbGncv6VbDZw3sRYKaqj/13oTWe9cub6WADS3hbDgE2noS6FcoUkrIF/ow5UIVol1H
	kBRBOraSc8Ue1cSz9vIfxh0gOZDQFaDMRYqSlkA==
X-Google-Smtp-Source: AGHT+IH015phUurBpWFmQa3s3RBwJ8PNrtRSaF1ujp3Q451/4hYQAF7Ccw77Ht0ZKlUC+7RE7PoqmmdadfJXIZMtLLU=
X-Received: by 2002:a05:6512:124f:b0:540:1e51:b919 with SMTP id
 2adb3069b0e04-54034112534mr504071e87.31.1734025095447; Thu, 12 Dec 2024
 09:38:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212-netdev-converge-secs-to-jiffies-v4-0-6dac97a6d6ab@linux.microsoft.com>
 <20241212-netdev-converge-secs-to-jiffies-v4-1-6dac97a6d6ab@linux.microsoft.com>
In-Reply-To: <20241212-netdev-converge-secs-to-jiffies-v4-1-6dac97a6d6ab@linux.microsoft.com>
From: Praveen Kaligineedi <pkaligineedi@google.com>
Date: Thu, 12 Dec 2024 09:38:03 -0800
Message-ID: <CA+f9V1OK39b5hNoVZqu6AfPJqGsB4_5iyAK24Oit-tjmxrk7jA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/2] gve: Convert timeouts to secs_to_jiffies()
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Jeroen de Borst <jeroendb@google.com>, Shailend Chand <shailend@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	ath11k@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 9:33=E2=80=AFAM Easwar Hariharan
<eahariha@linux.microsoft.com> wrote:
>
> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
> secs_to_jiffies(). As the value here is a multiple of 1000, use
> secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplication=
.
>
> This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci wit=
h
> the following Coccinelle rules:
>
> @@ constant C; @@
>
> - msecs_to_jiffies(C * 1000)
> + secs_to_jiffies(C)
>
> @@ constant C; @@
>
> - msecs_to_jiffies(C * MSEC_PER_SEC)
> + secs_to_jiffies(C)
>
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>


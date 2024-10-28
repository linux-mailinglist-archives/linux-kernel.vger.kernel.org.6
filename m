Return-Path: <linux-kernel+bounces-385398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3079B36B0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 194BB1C223A1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2625F1DEFE7;
	Mon, 28 Oct 2024 16:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QL4KLo94"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D378418B48C
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 16:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133424; cv=none; b=FMJmcA5ZUc6NflCoWQUqPvYmmD8OJdf+HkiBv+hR90cfq4jYe/lryWm0J/StYf4+0K2Mut35iFB2W0kqtCa4+0YAAHrkRXQ0+NsswPruyIsNrtuPQeLtpHRVtc/JSqhTfdsYvR2iySc1XALSQVluddH0fyvynN+9/DGsGl2/AWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133424; c=relaxed/simple;
	bh=A1cFervhOMCuUn1qMqZ24mOHhDxMc2MaSueVuQ58tpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lUhhvXu6f8hOJAtgSkek+mr1cE7MjbHbnuaPmg4J/UdnvoSrB20m0ZG1fXiIcUjPi+fEl1Amq4RaUflsH1ARj5aZcpKTCb6R84Iffj5IOJIypcx0RU+WPCVcHJHmfDtXTQs5P9Iys/g+8GjTAvuDDwA/eFQk3XLupf6HnY24qqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QL4KLo94; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e2e33f614e1so4784367276.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1730133421; x=1730738221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JC3jVJVkR0vXjc9v4X5cqN3AeydRxh4u+9f7UYh0hzo=;
        b=QL4KLo94HsXvdRICxiDuQJ3PVBugrW0AUDDLQaUqDewXpA/OdPnUfAoiGRbvoseDpX
         Ohjrfv4wYFXICHSvhpf6RP2hPaocKZeWIyu+NRQ+Ng8SYaetmCBT8xqFqgaJxK4ypo0W
         ympdDK/qdEuv4Fcz3GEL+NermkJosAO1OG7M2+ymGR0t29b4wkmKyorR3Vsa/M0WQHqv
         90VUAC4reIdNd9PcXSUbckPctQJbUGP2voPshCZoBuWpgmYG5mi9zCRV9oUB8By8a9MX
         3Pmq5N+dQhxFeNb9uLmEoi6acyFp3q3T5XeiHr/rPodbB+52REp8o4Hcxa+OfVYq7RhQ
         LQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730133421; x=1730738221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JC3jVJVkR0vXjc9v4X5cqN3AeydRxh4u+9f7UYh0hzo=;
        b=wc0u6DAaPhcDg+C1TcLknC350++DgWUveAW6AR9WlvA8Nezyb1E4bQLERnAkMZhQae
         u7g1stBXm4yhX0+I4DZXqeZyjRBkQs9Lq77o41zaJCsvkvs1/A13Q2CEsB04pJpnENZe
         pvHpr08MtTJKBtyBEH0z7l3bSlSPTxg0yOaDdsPbjKPsKSFI2wznlRoN9gK538lUErj/
         ubCIq7ttbhk/piVwVywDeLNy8eS/o1xajoE1AVcdymPjuV0qGhQ8pzLFX3EoJueGH5b6
         UISysoQxLWfAKMcFjAq0TqU7/0aaNgByGgV5KyCOF0YSHwEom9aMmDeYEZqkDDeiiBAe
         dmdg==
X-Forwarded-Encrypted: i=1; AJvYcCVf8TUxOqat2eW/34aykEAI6X2basOwdSsUN3oIVLAwXLAyPwJSOSXm0QSq27kKpe9Fsxtl2sjHIR5neII=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFv+PqHsL+ZInjJetaNyhZSpoGwR1x4CzcBZiG4MbheY64y6AP
	OVWLl7dM671b2pGc4ON4S3Fi7CVDEb+KfK0wUgX+ZXkwC1zU91PxvgefAQIOPSDWZ0J3FKKofUR
	GuhH1N/m0zaglvI3H9zYWB6Z8ByuKKSCjH4JJ
X-Google-Smtp-Source: AGHT+IHkyOUSrZWPFA3y75jsiO35BBFsma2xgU/eoM7XLdj4xLkzEHV54DlON8lAoxScSinKd0bNayTWXt4280H+XTs=
X-Received: by 2002:a25:d645:0:b0:e2e:2b20:492a with SMTP id
 3f1490d57ef6-e3087c21336mr7425173276.46.1730133420732; Mon, 28 Oct 2024
 09:37:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028123435.3495916-1-dongtai.guo@linux.dev>
In-Reply-To: <20241028123435.3495916-1-dongtai.guo@linux.dev>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 28 Oct 2024 12:36:50 -0400
Message-ID: <CAHC9VhTC3OgGy7FrmPTOG_qLoPFbUFqYa+bJvfB2q+uMkQWPWQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] netlabel: document doi_remove field of struct netlbl_calipso_ops
To: George Guo <dongtai.guo@linux.dev>
Cc: horms@kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	George Guo <guodongtai@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 8:34=E2=80=AFAM George Guo <dongtai.guo@linux.dev> =
wrote:
>
> From: George Guo <guodongtai@kylinos.cn>
>
> Add documentation of doi_remove field to Kernel doc for struct netlbl_cal=
ipso_ops.
>
> Flagged by ./scripts/kernel-doc -none.
>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> ---
>  include/net/netlabel.h | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com


Return-Path: <linux-kernel+bounces-523342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED32EA3D541
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33B287A49D3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C141F03D6;
	Thu, 20 Feb 2025 09:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoS8UXrk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7E91DF72C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044869; cv=none; b=mwgR7T4HrJ0HCfa1F35ujQiNfp+pdJLn9RtEkO4kHkXi/qI6HfkKH1P0szZiKRy9IA7Ll9xTDR/hsl17z9HYHFXN8fUMjqJM7T8Yd1O+ywBpOS/De9vKO7Oyo/7Awx0Icbo/fHSruoooBX3vB3Rh70yHnO4WpoVGHCY2H7ZL1OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044869; c=relaxed/simple;
	bh=La+sxiVQ7AWcdVq9kE+VkWAJmsPFAHXzrxjh2HY8auc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rR3d99FnWvO1dwwChVJbkk/k8Erz041ynp/XDAT2E2NPiwIwUEgVBBSbvO2N0YGJTJSSTAMpYLBjNBMh3tN5YJpQ3YfB1JDpc/ADpWJZ1h+RoWV6Idf9OiNf6MQU06cayrvh3oI3voqh3XpqUNaGTGqttKRaN+vBocIC82OaVWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IoS8UXrk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9271C4CEF0
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740044868;
	bh=La+sxiVQ7AWcdVq9kE+VkWAJmsPFAHXzrxjh2HY8auc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IoS8UXrkbtnnXof8REZkmHcLgC/gAUPDqsvLUzwJAX9c25C7PbE29py6GStdHv+MM
	 9yNQ6AeU9eAuGrT4QNyN3HwzJQm+3yWHodCiPdC9eLcyb+4xo8jTZKCMpy4UjAqzu3
	 76iAYQ6v62HqDrnHkGVTLSCszJUY/g1k6F8eJANLjGzmX0FGcZCWzrw3SkurdCoRZI
	 rMm9JVAIWj2PAlPF34Xxesi45Eul4B+zfAhYslYzC6/LJk0FJiKlciG+7ka+r1sEdS
	 cXNI0BkQiYmWxHykgmPZe2sFFy5GY5mhdgiCtBsUdZWhUXgQ56Dkm0iPgdajyYNVXF
	 zSVJEDS1SP8EQ==
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e5ddd781316so635992276.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 01:47:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWGRbUShGCWe/kyxFaUyyBOUMcgSKZ98mRblSZzzV+4lL16wq6RtYcXJxAktONYZRESqkoek5DScbcgEGg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy/6NSq1xfHL9u/b3ZKlb2Zh+1+6K6ntEUpBkSpz9m4fSw+hCt
	HmEF5wzZQ8g5z9vNUWWONk0z/ruJEh2s7Dvoo9xNxbUPujdnmFAre3d/hv1IfjOVHscc5qJbnTq
	7Q3SJRXiGD3HDBngPFatGVu9VW54CtzXc+vrdFw==
X-Google-Smtp-Source: AGHT+IHIa6JFxmshc6YyvYZzzJ5a3QNr0lJKaEbO7W6d5prUyZMBmpbGtD5ipRmOSKb6VA36xGLD4sBdhsm+2e5NeV0=
X-Received: by 2002:a05:6902:2a8b:b0:e5b:2a51:deb6 with SMTP id
 3f1490d57ef6-e5dc9082a7emr18061275276.25.1740044867684; Thu, 20 Feb 2025
 01:47:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220094456.32818-1-clamor95@gmail.com> <20250220094456.32818-3-clamor95@gmail.com>
In-Reply-To: <20250220094456.32818-3-clamor95@gmail.com>
From: Robert Foss <rfoss@kernel.org>
Date: Thu, 20 Feb 2025 10:47:36 +0100
X-Gmail-Original-Message-ID: <CAN6tsi4QZM_=wLyDtvS4BNu=HVt-z8vQFi8cYSYz+JfEWZTLrA@mail.gmail.com>
X-Gm-Features: AWEUYZm2ZrgMrQ1lqXfTXo8N61qlQPJPfTxrhTlmDHmEkkrmyL7gWUf2VCo02F8
Message-ID: <CAN6tsi4QZM_=wLyDtvS4BNu=HVt-z8vQFi8cYSYz+JfEWZTLrA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] dt-bindigs: display: extend the simple bridge with
 MStar TSUMU88ADT3-LF-1
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxim Schwalm <maxim.schwalm@gmail.com>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 10:45=E2=80=AFAM Svyatoslav Ryhel <clamor95@gmail.c=
om> wrote:
>
> A simple bridge used in ASUS Transformer AiO P1801-T.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../devicetree/bindings/display/bridge/simple-bridge.yaml        | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/display/bridge/simple-brid=
ge.yaml b/Documentation/devicetree/bindings/display/bridge/simple-bridge.ya=
ml
> index 43cf4df9811a..8308e833938d 100644
> --- a/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
> @@ -31,6 +31,7 @@ properties:
>            - ti,opa362
>            - ti,ths8134
>            - ti,ths8135
> +          - mstar,tsumu88adt3-lf-1
>
>    ports:
>      $ref: /schemas/graph.yaml#/properties/ports
> --
> 2.43.0
>

Reviewed-by: Robert Foss <rfoss@kernel.org>


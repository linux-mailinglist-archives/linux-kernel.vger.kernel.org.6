Return-Path: <linux-kernel+bounces-382133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEE59B09E1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0CEB1C22CE6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC4D1FB88B;
	Fri, 25 Oct 2024 16:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nuD6RI6v"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06B6170854
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 16:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729873517; cv=none; b=fEXws/K8R3Ii986NDUPdr3hQ7NXnNjKxWLqRXGjxdt9FnwptoUpf5VDe5nrUV68qKalqI4C5nPdL5tZXUyqZdRsVim5qQwpPMglCDWNX1+pGHIktqYEw/V4ia58hlSnq3WuiBRpZlwGUX7KzinO9h1W1HjslOB0FN+1mzoooXwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729873517; c=relaxed/simple;
	bh=bjUOMPmvbx44ArgARxQu9uiGnjONQ5DYJ9GEwVmwkiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=llrfufxhcLjQMncgA6zdKYGZkDu4WzEQ9pEwRdeCeqX/beAtdYXmKdZ8XojYX7hZXjiN61HTW8ZeJPAGSzxP7bD3woL/zcZTZf/Bd4Jrka34AibK3QAkH+xDH83M0h9II3kxgGS265naRwGA7BPE6PzJWwDhGnESNJqIj2tjz20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nuD6RI6v; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53a0c160b94so2693230e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 09:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729873513; x=1730478313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjUOMPmvbx44ArgARxQu9uiGnjONQ5DYJ9GEwVmwkiU=;
        b=nuD6RI6v/5sB0eZ/JqCtTFJtX6lWpNuHrdSGNRa0R+ymcn3kgz8asTdvnc22rCYU5v
         fInjfOiTgiHnoZlkOIP7xgNfRP2cw76APqcNpoQN5JlfobAk6ur0EfkKkcCr8hcJ5487
         UQWVx4v4RMa+1j0WtUDYrpZYRvm2/+0ArmHVykKrOkhwGCqzEdmobmJC2DgVB3vUCC2n
         uljd6tvHh0uqky2JP8T44ewkyyKOrML31wvKE51Fiua+lPyrocRqaC4RCTiPVMQfroxf
         fZlqa4lGRRD33J6fhIIjuAuLNjm8JzJEn/Ysisu69AKoXKcwvB5Safot42JQJ0P6uEe0
         NCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729873513; x=1730478313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjUOMPmvbx44ArgARxQu9uiGnjONQ5DYJ9GEwVmwkiU=;
        b=ktZo8EKDUQdd+lf1eZU+NO1tlDvAoZDasKONl8cibj3XtFdk3k5pLoqnVJSKYzlC7+
         8caEp3PpKXBj7t4iHK9/yGxvwGYrx/6LNxQSHN3YV6nSBxbaCZxL/dlBD2wpMu63rzI4
         AsxACeTWiib807XFD+iSPEtnwKpG4M99Q7Hkr46VRL9LUjdYItp+p+eNBl6hLE50KV40
         Xk3f559xoKTMw33z59M6LtBI4LpM0SQKrheI2iEVDc5n98uc42PCzSe9vX07q1/PKn+G
         4BN0T0UVD0/taDnxAgDr+QBs7A39fqlyHwPCDJpswbnoLhon8uo2t1lgFEZiYi/iiBLG
         IXCg==
X-Forwarded-Encrypted: i=1; AJvYcCX209FKVyelmGyiow0IHzoMOq9f11bmAMy+TukBALOQyfomzrMCoyG1tR9+wACkiKW6WurAEKoCcTMnBik=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnGO/yegFycZfMbSWkyghcZLngYkxdeRsgqNtiQ3Udwt6lMTCt
	P7mkiygadknlO5Xw2Eoj8qRh8kBQu8lnd5gXoS8yi2V4zCjQSz5MJ527mCBGn+Z+Qg9vxWwDJnM
	cRahJuRF1WsHnJlGsC6Hsw1v4rPq6S3krxCYH0Q==
X-Google-Smtp-Source: AGHT+IGGbBVl6KvFdNDYHMTLMjeWLk56PcWbppKi28kx7t5pXxobDS9F5kYDuNnV/DVw3aRo8x3rgKDyjodwVLhSfDw=
X-Received: by 2002:a05:6512:ea8:b0:539:f74b:62a5 with SMTP id
 2adb3069b0e04-53b1a30d646mr6103175e87.25.1729873512702; Fri, 25 Oct 2024
 09:25:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1729738189.git.jahau@rocketmail.com> <a899d5f0525a76efeab6f734b75e1eb95d9a2ca3.1729738189.git.jahau@rocketmail.com>
In-Reply-To: <a899d5f0525a76efeab6f734b75e1eb95d9a2ca3.1729738189.git.jahau@rocketmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 25 Oct 2024 18:25:01 +0200
Message-ID: <CACRpkdYV5jEKzZUOzWMB6XwQseoORwVXiO1tEHVrC1O1GBauTA@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] dt-bindings: display: panel: Move flip properties
 to panel-common
To: Jakob Hauser <jahau@rocketmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	~postmarketos/upstreaming@lists.sr.ht, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 5:18=E2=80=AFAM Jakob Hauser <jahau@rocketmail.com>=
 wrote:

> The flip properties were used by "samsung,s6e8aa0.yaml" only so far. By
> introducing "samsung,s6e88a0-ams427ap24.yaml" they become more common.
>
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

I think I even have a legacy panel that needs this, good!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


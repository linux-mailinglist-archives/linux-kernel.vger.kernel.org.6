Return-Path: <linux-kernel+bounces-556842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5CCA5CF5A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D09293AD036
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A8E2641E8;
	Tue, 11 Mar 2025 19:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4PTllD6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447051C6FFD;
	Tue, 11 Mar 2025 19:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741721323; cv=none; b=guUwqoPppf+RH23gzndPJ5loBLHZbgyoBIY4kaiuskd87pBjUGToPNQXsIRoFbGe1xzzTcCetdR28BuGMGblHYU/ajjpkHzRzisgi41Vw+iFWxZvZqpwVy5lgr661UfEek19Xc1GwlOoT5HK2cv/+0fJA8HHug5fUxq8JPniPPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741721323; c=relaxed/simple;
	bh=H3kO2r1YHqxOT0791Hw1VPh7Nc7EXwaxXhF8SUKEhAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKHvG6rmSoYF9vTl9KfOWunte5Cuwuf5t4zMyatQ7QowMb5hdlzH7mYO5ccwLboTlhGipTlE8WlUlnfs+LQ2mS0dTlg2UL9HqS+do0OTQz58rG7+cTpEo9fG7NRxJQcaIds/nmG7S75D9qKTKKPmBDMKSv2ufz9gFKwy3nWLbw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4PTllD6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B460C4CEE9;
	Tue, 11 Mar 2025 19:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741721322;
	bh=H3kO2r1YHqxOT0791Hw1VPh7Nc7EXwaxXhF8SUKEhAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S4PTllD6WjqfM+ONBVzQNHYqwqJbS4VN7qu4hpUiZvOqQAMrkl8GMVB4LNZvOp5GI
	 HipPgYYCwc8cowhS9DVIKvW6suOv2pbZaTOQ72qt4pT4lwuT+/lfKjYfuQQFKElXr/
	 9grSNR+KjyqhUECE65UQbKQDtHnvY2Ii4m9KGn5gVtNz15lRXPpOP+1uRA4fQyhSqr
	 uV8tPAtKbfz5F1S/hK+x9yG+HnV/rqbST7e9TUDyOp8+KDTdH15L74JrkPoGGqHtHg
	 mnn7oYmGpP/4E3hjxY4qxJbxTvObsSBy0DVe/htX4/v3qQ+hy8lrjaHVHtoiItWCug
	 2I5cCQC7CxeSg==
Date: Tue, 11 Mar 2025 14:28:41 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>, linux-sound@vger.kernel.org,
	Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jerome Brunet <jbrunet@baylibre.com>,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/6] ASoC: dt-bindings: meson: meson-axg-audio-arb:
 claim support of A1 SoC family
Message-ID: <174172132043.4178261.11828911327621158641.robh@kernel.org>
References: <20250309182127.1322890-1-jan.dakinevich@salutedevices.com>
 <20250309182127.1322890-2-jan.dakinevich@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309182127.1322890-2-jan.dakinevich@salutedevices.com>


On Sun, 09 Mar 2025 21:21:22 +0300, Jan Dakinevich wrote:
> Add "amlogic,meson-a1-audio-arb" compatible string alias to
> "amlogic,meson-sm1-audio-arb".
> 
> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
> ---
>  .../bindings/reset/amlogic,meson-axg-audio-arb.yaml    | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>



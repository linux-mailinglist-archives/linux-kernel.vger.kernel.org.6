Return-Path: <linux-kernel+bounces-336134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80ADA97EF90
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFA1CB21B8F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C47819E98E;
	Mon, 23 Sep 2024 16:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fKxbYBS9"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73DD13D625
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 16:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727110238; cv=none; b=UV/gqu1DgZ1MXB7C9N+6qYdqJwZ/BNrxGdFngFCfyqzv3oyBrqwTHrzjI5retopzsaCihYngYIurk2zSa2ak2CdbITHbIi+nHrTn+NEAGaX4VJB/5Xtum3hyMVB4cy41gDsfaojmTvDvyGpzCcsyjm4Al0YScyWAwNPwnCH1s/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727110238; c=relaxed/simple;
	bh=vjNp5Slgo9fXWX8BFhhhJTy3UK8hnpRCE/3LOUsMVkU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n86V8ko6s8Dl1LZRd+Hjl/kg5VR/UY1SBmmGmtip/VtutZYljmwf6eREuS53tVl9WlUpPFVtrHfrVBsBJicVGMozO4ikM0jPZgfQPNPou3s4ZNWdkcWe2D/tRyhsrvmQi1dKWbj66lA3oGIn7iAMTBEpD1TpD7av5EgleBqZAbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fKxbYBS9; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42ca4e0299eso36928325e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727110235; x=1727715035; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yLlr+wSve0JF6A7Evumzl38Kt02Awbpgg2gNxC+TIp8=;
        b=fKxbYBS9eqBZ9WlQHbpti344hfCJtP8t0QddwFe1ASXY9XwZ0UDV/v2VIX9zK6XYZ+
         do4YxdRXdPjmjcAL65+985LtK3CUjBbeNtmpKXkUFZBPZq10sM2eExujlafRYGBTCcPz
         mgMseSa89xYtyAUEU4bxDe1ZKRSPr7HcFhWfNRYlmdVJRkBbDWh/3e7XxQ0tebzqKyee
         S3tesfolYdo6w48zvJ5RCA5zOZRhCNZEiG3ZsMIcYrG13UJaMgFcr+2AmkQrXSTN0DNO
         3NPOBUjgMoDjLUyL2uK9/qOjwhXcZwoQbovIu8zei4drdeTgePDr+Sk+kC4tZl8hPoNh
         SSdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727110235; x=1727715035;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yLlr+wSve0JF6A7Evumzl38Kt02Awbpgg2gNxC+TIp8=;
        b=tzLKexIi6QLqmu2AFabcYFODwJ13mSZFqUNQH2/rdr+iwVsxDZcA4CqUQGMExZuIoP
         LRa6ZC1+I+L9wLeTsfN7yBEfPlL+8Z9IDCW+VrEciXLRf4OR9MBA4FBQyxXrV/74Js1t
         7unTL4mqSfp9gbdX1rngBR0mE0+bJMmU5HwxS8uIUn1+bnmSki3jWzBAccZnRP9JFeC/
         xERVnVLHYLMGUwER2UAb/UaCXvn3sOWOzqxjq64iAEs1se73PN188UcyRddTDQ7CMhMm
         Z3kCzlhg/+52b9lyqtD5WIFzVhYH50Ju1RSur1Gnow8GZdI/pJTqUQpJfjgoQstWxuWx
         z8xQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpQicmn2j5bfrz3ESPBweUSC3vuSflur3vEhUO09i/Vr8yZ57iCgD0kK16vHeWkXdmyE3nbGALFGwEkCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWo35kqRqasiAPJVaKHPfj29lJYNrtuBxRl2VWhYxyBy+WZmMU
	d5aMBUFZwxoSkWWaxEljRiI/N2NJkotw7vmCGBuRo0tArcRBXjTZ3FHsR/PIaGU=
X-Google-Smtp-Source: AGHT+IH7odHo20L+pIy8O6hrw1pshPZdS4E3+uE8AB02v0/adG7mc3tsnL68SgsTXJYX57tzVaoHUA==
X-Received: by 2002:a05:600c:4ed0:b0:428:ec2a:8c94 with SMTP id 5b1f17b1804b1-42e7c165df5mr81914755e9.10.1727110235170;
        Mon, 23 Sep 2024 09:50:35 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:885c:440c:fff5:ed00])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e75452b8esm132039915e9.28.2024.09.23.09.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 09:50:34 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: do not ignore provided init_data
In-Reply-To: <ZvF49CZhRc2rrPQ0@finisterre.sirena.org.uk> (Mark Brown's message
	of "Mon, 23 Sep 2024 16:19:32 +0200")
References: <20240920-regulator-ignored-data-v1-1-7ea4abfe1b0a@baylibre.com>
	<ZvF49CZhRc2rrPQ0@finisterre.sirena.org.uk>
Date: Mon, 23 Sep 2024 18:50:33 +0200
Message-ID: <1jbk0ez546.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon 23 Sep 2024 at 16:19, Mark Brown <broonie@kernel.org> wrote:

> On Fri, Sep 20, 2024 at 07:21:12PM +0200, Jerome Brunet wrote:
>
>> Note that it is probably not problem at the moment since no one complained
>> about ignored data.
>
> I'm fine with tweaking the functionality here but since I don't think
> we're using this at all we should probably warn about systems with both
> forms of constraints specified since they probably need some
> consideration needed and people might not be doing this intentionally.
>
> That probably means checking if regulator_of_get_init_node() can find
> something and warning if that's the case.

We could warn if both init_data and desc->of_match are set ?

Setting desc->of_match is an indication regulator is expected to search
DT, is'nt it ? Having both set be the indicaction of the conflict.

Maybe the warn is enough then. Do you prefer if I keep the change of v1
or drop it ?

-- 
Jerome


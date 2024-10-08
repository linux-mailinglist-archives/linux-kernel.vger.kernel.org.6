Return-Path: <linux-kernel+bounces-354777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A773D994275
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4F941C21500
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADB01BAED7;
	Tue,  8 Oct 2024 08:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RdfB4ZuO"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B08191F97
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 08:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728375383; cv=none; b=aMRQtZS5lHENdQZEF6P8nqRkVPIy6fIkldqSIPT/VIgw3NL5iRNLMrTVoWG18+X8DwvMPwX/uFqEEaT8EP/9xk5TzvNLRGdigLOthkz+aLDk3ZDAjMNPiWCM9b+yhT9J/vhh3NIs35y9ZVvJDLyS2CUEfg+Cc+9hqYcmgLqPaIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728375383; c=relaxed/simple;
	bh=1DVV6aCKo57cITQ/L5onrD0sDXRLtOftYImjic7g0ZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZTIU4DDYcvTYhvMK/scIlrW8AmdiZD7Oj5Pkfg02+hR7I7vAegWzhJDSVeXqsMHE5KCsKNxnnEL71HU71lXiGHyqUA4vRzSRsyxlRlv/T/Ocg4jdgwcIlPoQUWQlQkHUjMyYA4oPcoTWF/iGbleGXQxmEq86gAh4HJR6bukUfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RdfB4ZuO; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7db908c9c83so3359253a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 01:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728375381; x=1728980181; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S995Kpw7Q5FgEfl8cukii355dy4P9Kqet+lLT/AJgBk=;
        b=RdfB4ZuO/58P704ZVCnaI/UkC5OTTkk1uc820g42LDvCy2w7ARkWhkHN7x8bhuoj5q
         uH8lbpbwY5Imgjov2eRk+0C/OXO9idH1OzzbXcEOBQOzX3O7+6ysMENmZz0rGdDeJch8
         D/8/qT0O7T1AqsGxyB4244GrGbeFu+zEdJbw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728375381; x=1728980181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S995Kpw7Q5FgEfl8cukii355dy4P9Kqet+lLT/AJgBk=;
        b=lrqph2eAFfuZtDmqlFVwJOa3OEGdBE3r2p5dytQakNbySb4sb327jIM+Aa5i285rbr
         crlVZNUqFcdjdf3lU3DFvcpqnntaYcbjbki/boH80A95VwbnJIjZFpSZn89dTDDCqWAd
         SGkMQyxf5PA+GVYnvHGYr6u48C5jKoO+aC5+wt5K4Wvo8TtMrdtAp5hyZdk5DzD1nx+9
         PjMO2LcuxFIM2KO8BflLVMr4UuK9GGRqkYxHpI6wUahyl6EgowkgptyDoTwjI1Q2WUKz
         /TkHMcS6yshVF7Th/X64fNGB6curFeRQPT0CUEuNDuIiaTiDE42FqoMNMFA8ujv3kUI9
         EjqA==
X-Forwarded-Encrypted: i=1; AJvYcCX49mkyEQvQfC2jpRvoEBs1aEZYLybSVOpNwwHiOFXaUk1V14AZOnJThMs79No03J6BimCF02l8bIVN63s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRFrlydH/8QZcdEph4skq2XaUeFD11AgVQKFqEiXnMbUbSyVnr
	aRQxRMg2I4nS479kS3Hr2eY93MjeLle3mR5AB8qtF2qi1KZ8oTYWYQoeY2QEAA==
X-Google-Smtp-Source: AGHT+IG1t262MIOZEYFnYoCHct2S8wc8u9PdiAmbJsD0k0DmGmjbRhJKVQFe9ZMXZmzrCWQUeq1YCA==
X-Received: by 2002:a05:6a20:9f0f:b0:1d4:fac8:966 with SMTP id adf61e73a8af0-1d6dfa27e8emr23031407637.10.1728375381636;
        Tue, 08 Oct 2024 01:16:21 -0700 (PDT)
Received: from google.com ([2401:fa00:1:10:10df:d27e:8d4b:6740])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0ccd04csm5610451b3a.46.2024.10.08.01.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 01:16:21 -0700 (PDT)
Date: Tue, 8 Oct 2024 16:16:17 +0800
From: Chen-Yu Tsai <wenst@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Hsin-Te Yuan <yuanhsinte@chromium.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Enric Balletbo i Serra <eballetbo@kernel.org>,
	Ben Ho <Ben.Ho@mediatek.com>, Hsin-Yi Wang <hsinyi@chromium.org>,
	Nicolas Boichat <drinkcat@chromium.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/2] arm64: dts: mt8183: krane: Fix the address of eeprom
 at i2c4
Message-ID: <20241008081617.GB3999626@google.com>
References: <20240909-eeprom-v1-0-1ed2bc5064f4@chromium.org>
 <20240909-eeprom-v1-1-1ed2bc5064f4@chromium.org>
 <01020191d6972ef5-12c59f31-ae58-4aad-b33e-5b7618c0443d-000000@eu-west-1.amazonses.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01020191d6972ef5-12c59f31-ae58-4aad-b33e-5b7618c0443d-000000@eu-west-1.amazonses.com>

On Mon, Sep 09, 2024 at 11:41:57AM +0000, AngeloGioacchino Del Regno wrote:
> Il 09/09/24 10:33, Hsin-Te Yuan ha scritto:
> > The address of eeprom should be 50.
> > 
> > Fixes: cd894e274b74 ("arm64: dts: mt8183: Add krane-sku176 board")
> > Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Ping for this to be applied.

ChenYu


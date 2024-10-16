Return-Path: <linux-kernel+bounces-367786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7C09A06CD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52F76B21462
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46A1206069;
	Wed, 16 Oct 2024 10:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JEX1Fnl7"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3E9206050
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 10:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729073618; cv=none; b=lNUPlVd91ihMLI/kNdclLCLFURSQ/jLNgIp9RdHG878beSd1buVzGp9fk9LsZt7tjpVh0+5wGcIyr/2kQuAoZ9z7E5C7Ga0zUSKgk+M8A58gej/IUbzKii7XGsOS0/MTecXeyqV9du3750Ii/0Cjo3MLoquIiLKYfLOAzW8eY+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729073618; c=relaxed/simple;
	bh=sTpNMXaIJd/tykyOeWQvnj/gXyEnEe8k63moPoH5rpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kZ8W7tYOOQHlhS06oArcH8re5F+7xfqP+4+s0UXD97IDGUHqtGoYK8ZO2VnqGGfkepljIPPwytuwqZR1uTCIe0uIvk4mQyWB/63wQeRiuDyAH/45DZVY9z0M9aSnrxIxDVQ4tE0wZdAWPQagMCuvg9JIM0HeOdx65o5s6dNTRhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JEX1Fnl7; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43054ddfd52so9895865e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 03:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729073615; x=1729678415; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iQV76dFDay/RqoOK3n1owkKRFm9VHZ/1Bv508jFXXL0=;
        b=JEX1Fnl7Tes2LXolTRLy6M031IXH/++HEkK3S95cV/EHaUTA41O5qwJ0VIOE3G9UQb
         g1fJZdImYmQ1MjYj6C9k/dOW646jTGiaagyOw2RA/PTuOWz1vkWFygxq/7WvmpOchfli
         Y8Z5McwPNwQGxqhWnASKB6JLTrz0WSrKDhBsleutf92c5G76MjQaS5YOKlWoJ+kltLOv
         9EXFiyc6RjxKd8aUHsF/e07cV2joya/YZHSL2EjcA0xCVhLqhfsND2SaiQTetH+52Ncl
         YIs9s99+84hSrqFjtOL90c6ZMwbhkJmXwWyi/a92ruPYkgkVo0T0n5awbQLMFfSkPKxc
         dTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729073615; x=1729678415;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iQV76dFDay/RqoOK3n1owkKRFm9VHZ/1Bv508jFXXL0=;
        b=upAWGXJKMt/vcyYrD/NaY0TdaIr1KClCT79XFdgt9o8uuJTo6n5sO81zA0ubUjMQdE
         MyVAa9QGrkX1rJeLqkX8OgjVGptWVHBrFUnC1rGzJKXvuyqv91Opaj0qS1mdWHaCMK9Y
         gvWWpohWSMz0Bm824RBtq+E6o8fQq/ZXId+8fL4aC+agrucamYLb73QWdz7qKtKDdhpp
         gzF+qJHMLVDq4D6N8vFy/oeG4ueF2PoD36cOCEnBj7Eb+9cdU1LprSmgp9UeCdd8UQ33
         3yWWW2Jqy5WnSyx89GsLpUvtdc9wvL9pJXJFirkRR7ZyceHWEuwFPuo8uBEAvn5cPu+J
         e3VQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0v7CU9ze17qRh19OTcYaSemO1ERY30jG+vBDvCSgS3vu+t0BUN7AONOl2OfSkiH7UzLvoixJjsObmMW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YydkOMiHHkfu/0Gsb5jFj48Le95i7CPD0axRlmgVShpnm9NphEc
	lh3kv0HOPro9A8X/xIj6dzy25eZuJIIZi1KyT3JgFHsYEyMgqAeAATui7OQiMKQ=
X-Google-Smtp-Source: AGHT+IFHlJV3hiZFBUSxxB9Rj2t0eST2XqG/9mqKeve5QAUc0itt9cDVkKN369ZirbCtD5pq0QrF/w==
X-Received: by 2002:a5d:6c6c:0:b0:37c:d49c:3aad with SMTP id ffacd0b85a97d-37d5533439amr6249086f8f.11.1729073614556;
        Wed, 16 Oct 2024 03:13:34 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa7a055sm3950545f8f.1.2024.10.16.03.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 03:13:34 -0700 (PDT)
Message-ID: <fe800086-8436-4144-a7cf-e963c0749d7c@linaro.org>
Date: Wed, 16 Oct 2024 12:13:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: spi: Convert bcm2835-aux-spi.txt to
To: Conor Dooley <conor@kernel.org>, Karan Sanghavi <karansanghvi98@gmail.com>
Cc: bcm-kernel-feedback-list@broadcom.com, broonie@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 florian.fainelli@broadcom.com, krzysztof.kozlowski+dt@linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 rjui@broadcom.com, robh+dt@kernel.org, sbranden@broadcom.com,
 skhan@linuxfoundation.org
References: <09826ffb-b7d1-4244-af0d-854f1f0339a1@linaro.org>
 <20241015180906.8464-2-karansanghvi98@gmail.com>
 <20241015-proactive-backlog-b77c42eef79c@spud>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20241015-proactive-backlog-b77c42eef79c@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/10/2024 22:25, Conor Dooley wrote:
> On Tue, Oct 15, 2024 at 06:09:07PM +0000, Karan Sanghavi wrote:
>> Converted the brcm,bcm2835-aux-spi.txt file to
>> its respective yaml file format.
>>
>> Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
>> ---
>> v1->v2 : Made the necessary changes in  the yaml file 
>> suggested by Krzysztof Kozlowski
>>
>> v1:
>> - https://lore.kernel.org/all/Zw1Oj1utiBJ9Sosg@Emma/
> 
> I don't understand this patch. How is it converting a text file to
> json schema when all you're doing here is deleting stuff from an
> existing yaml file?

I guess this is supposed to be v2, but it's all messed up.

Karan,
1. Respond to previous review.
2. Prepare v3 incorporating the review.
3. Properly use Git to amend your commit - proficiency in Git is
basically a requirement and we won't be teaching this here. This is
kernel development, so assumption is that you know how to use Git (and
not Github, these are entirely different things).
4. Send v3, do not attach the email to some other versions/threads
whatever. Just use 'b4' if you have troubles with 'git format-patch'.


Best regards,
Krzysztof



Return-Path: <linux-kernel+bounces-409476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2C99C8D34
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9530FB2A40F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3331644C76;
	Thu, 14 Nov 2024 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4cH9r4A"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39692FE33
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 14:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731595556; cv=none; b=L/LSYHrfGAZWPRkmOTnQIN/CTqHxiR/aNBQY7jJ5IcPMB+EnjmbXXiyG6ggpKb0rJNZ9G+BxUgHEOdgliHnXqjgVVKSLoUllBJFC5QBxGNoj1d4IQs6ueT27JIZRhY1/OGuVh2mYWmGPZ0TVlKtHPW/rK5ce62q9TkW2llh4HQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731595556; c=relaxed/simple;
	bh=0r2ZB99i4+6z5Vmt3ozbu+Fb5cePfzkY7N43Py94qK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H/JJWiiODcU9GOkJQOSTuoENYZlSYdVymn3ht5p+PgjNmlPW30OvoK9gHUUZK7S/Ky4rt50RNfHbUJQ1/Ysebn0Kj43/Aw3vuIWbbKLEJcqR/LsGiDfcJYg8bFqTcXnASqNTMqmCkS8OEDIXf+LcdkDw3TtC98omaN1jQ22vwNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4cH9r4A; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7edb6879196so564374a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 06:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731595554; x=1732200354; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=GG+so+wBCscOfmrTJUUkNXvmHqzEZPI5QCaJTXJSAbs=;
        b=C4cH9r4APWtvyWjC194+UALdJw9ivRS4xTpfHQQMU9GJ9HsVuY3kbYReIwA0w/MqkU
         MWUE6Dcby6qZbtFHWhJkx843KRntwVKJJrC+eFgi1BSMCJynXOjl4ZdYe3efk2JQGmVC
         aFpjlPJ+/rDiR5G8Z1rCfPzHdZghdAmNhuuUD3ZET3V5ON+gthnFu3OajBSOcXSdMnGy
         n7r5Uik7HZnPLWEz3OjI+wu3NqJ7Xuo5DzWOobF5hc9crfrTpO6aRdjJ6SBRNGsfQdIW
         7//iVmTwkZ9pGtVbe7DC75mrhyHBlob3DLGemTj58mDyQKwnWhO1pySe5G4WbDI54NLk
         N5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731595554; x=1732200354;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GG+so+wBCscOfmrTJUUkNXvmHqzEZPI5QCaJTXJSAbs=;
        b=DJYGuyPLNW0rJnN8WyYaslU1pC4e/j3r9kXQAWjohZuEWvLUnbD49wnT/QPHUiMofO
         xhRwdZ+tSd8VA4/9JW52gBszf0JoM74s7zQxQmJCE7CZmkG3xS1FyInA8qrY+uEot8Ny
         uH78Hsl0zNytwvYIpGgXg+/aghlpyDC1w/BG5WTV4FhB8drTt+yh357sE1XQ+PpOPDNV
         NzmF+jZ5i5TjKvgMRAyobD0kQHpXom2DDcsF2HyFeWcrm6tPIALV589NfiyjKYN1H9Md
         8VPwbs8dnnXc0Odjfq5kvguTdqnGtwPfNJFr4es34a98E6gMniK7DloPfC5Z3G7zWod7
         HBeQ==
X-Gm-Message-State: AOJu0YxkHsi1aBJGDhHfdXlVXWI/lU7c0u8M8RQmNfmh4SLO7pCOrLT/
	vsTEvWavC9Y7BvK7tv9Sezqn0QJTq0HRdvZfc0rRFcOuqF6OWSxo
X-Google-Smtp-Source: AGHT+IGTS41g8n94FMs8oUdx/Awvi7+Vv4w8LJol8o+vlikSHLuIMWL7h47JbNa00CGaGYwwO+If1Q==
X-Received: by 2002:a05:6a20:d80b:b0:1db:f05f:55c1 with SMTP id adf61e73a8af0-1dc22b642e4mr35039567637.30.1731595554171;
        Thu, 14 Nov 2024 06:45:54 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8b3974fd1sm1184470a12.65.2024.11.14.06.45.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 06:45:53 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <85584c2e-2c45-4ec4-89a0-111fa5ad1080@roeck-us.net>
Date: Thu, 14 Nov 2024 06:45:52 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: regmap I3C support
To: Mark Brown <broonie@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Frank Li <Frank.Li@nxp.com>
References: <67d549d0-64c6-4d62-add6-0958ef24910f@roeck-us.net>
 <ZzSxKctLlLZexdF5@finisterre.sirena.org.uk>
 <feda265f-f7ba-4017-a08d-b35916aafe96@roeck-us.net>
 <ZzS6ph8KulEITt5C@finisterre.sirena.org.uk>
 <88f34137-b215-4bee-b117-3ff00402ba6c@roeck-us.net>
 <ZzXfmonkRB-KaBhi@finisterre.sirena.org.uk>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <ZzXfmonkRB-KaBhi@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/14/24 03:31, Mark Brown wrote:
> On Wed, Nov 13, 2024 at 12:16:37PM -0800, Guenter Roeck wrote:
>> On 11/13/24 06:41, Mark Brown wrote:
> 
>>> That's kind of my question.  If we are going to have this sort of stuff
>>> we should also have it for I2C and SPI since it's such a common pattern.
> 
>> I'll take that as "we are not going to provide a dummy regmap i3c registration
>> function". Thanks, that is all I needed to know.
> 
> It's not a definite no, it's a "is this just going to run into the same
> problems we ran into with I2C and SPI and never get used?" or
> alternatively "have people figured out a better solution to the problems
> we had with I2C and SPI which we can adopt there?" - it's something we
> wanted to do before but ran into trouble with.

We now use

config SENSORS_TMP108
         tristate "Texas Instruments TMP108"
         depends on I2C
         depends on I3C || !I3C
         select REGMAP_I2C
         select REGMAP_I3C if I3C

and in the i3c_probe function

#ifdef CONFIG_REGMAP_I3C
         regmap = devm_regmap_init_i3c(i3cdev, &tmp108_regmap_config);
#else
         regmap = ERR_PTR(-ENODEV);
#endif
         if (IS_ERR(regmap))

Clumsy, and not my preferred solution, but it works.

Guenter



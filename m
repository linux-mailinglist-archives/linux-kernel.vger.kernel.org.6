Return-Path: <linux-kernel+bounces-204478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7978FEF9A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DF9B1C25C6A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B825C19AD74;
	Thu,  6 Jun 2024 14:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaOFHSwm"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD0A196DB4;
	Thu,  6 Jun 2024 14:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684267; cv=none; b=QjrIVJaNNxgTs6xf/R4zOYH+JP8nEkETwGmXWdzjqaxMNGy/6YVhi56HGe/aJAPne8ZvzFdEwexim1WcAcsRAVIqR2yah923nci+pbJ7nwF702/8zTjACVBXlthjVOyt3+4VFK/iRPBcd9lKv/uD4/YAwBvIDLN7PPY//uiLodU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684267; c=relaxed/simple;
	bh=n7eQAgqFrklHoWNTTtvx0HdmZAKgyA0Rg4NkkBXt0uI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=VGv7Plq1HSfYMclh9BBXKxYbrfJciYLTEHKoX1Vh0i6U4Uq3Wjib3um75j6BgZLkbtXuevd58ngfLqBesKI0XQAuqyB6P4omPTs18lu5TZ2YyO4CGx+wV8G5arK2tf1Dzn9Jjpc9/dcYjShkKaFmTxxQvMfbiCf3lajrVYdDGog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YaOFHSwm; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a68f1017170so130213566b.0;
        Thu, 06 Jun 2024 07:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717684264; x=1718289064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Irbw4hNhnmRrLA4d4rMlZj8kSK2cUPNwpibn9I3pIY=;
        b=YaOFHSwmA6dBC3pCWi1acRohMvjBr/EFYQdleB2uu2tdU6UYLmQFiroauWRvVVCYDB
         OdvriS2vVTQbH638D6KA1lUwhJlJLhlhfV88AXA+jbtlPwggbL9vq+VFzZMnMaWfbEKg
         zoTYKIGA+20CpVhAwqcat3u5d75WkPQEV5l7nnejHCCifMfTs0SX29AkcDtPAjkaa4C5
         8sovRoPJdZSWmVzfvOgoKtnPifs18JHcHkk2ZS3XmeQOilm0GLgf+Jz5IEJTapY6+YLF
         aMsGXXzdnJ6+bvrtM7gDBDppdThuvoVjPp6YaHlA/X3ZrJuSqzKyKmSmEEueVs1ioJYu
         GkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717684264; x=1718289064;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5Irbw4hNhnmRrLA4d4rMlZj8kSK2cUPNwpibn9I3pIY=;
        b=K7M1MZqUPl8njSBpM93tROnsDUSAiyzsRUcEwD+bfc1dcmWukr/gRFG4v9NunZIQCR
         63KencVE+r0oessuTF+zOK3kdcp+7PdrukmDG4dWuu4IgTscuI6A7omvD0aHPhnbtFaW
         Md9ppXlRcZvOBwTlyfKy+VzKpgdwuV1JYErCC4Wtsvj71JS/gtdFGyHXh8WqnZr1QQiR
         5yx43MzyGt0Rloul004sXdc0GOaAmVO47p865l/+HCmYKwonVbLhSWIr3Ia7BTs934lJ
         bOoauJm0+GxI0jrw757VLiHyvTp0IiRRSJADr+46u9wcLn/pW1sbNnOJ6JxdJfKnbfaJ
         PvUA==
X-Forwarded-Encrypted: i=1; AJvYcCWZrAsz6up5+wfh8qp/ohtjFErFxJg2xDkYIAEQGqs8DOY6dSt+wh+FDLoudV0ZdUc/kMhRrrox/syT5ZHxn9MRqK3IbxKiP1YDYVyS33m7Lk7Vdc34TDWjHT5xfZTXXlB8ZqfMR8hISA==
X-Gm-Message-State: AOJu0YyJFwqNFms12bL7KJcJFIdkn0D7377+lMkye91vcEJ7W7dE5e9Z
	O/2Y0RaHWNgGS/3ybNSz53Er24uN+LXi12IydFxENB0cHMftexwgqdde5w==
X-Google-Smtp-Source: AGHT+IH8sHZgu1d55sXBe9fnboQhZHmHydOtUhaKeJwLSfjMQslJIkURobVglQD6mtMz46eurQaOcg==
X-Received: by 2002:a17:906:ca10:b0:a69:12f8:8998 with SMTP id a640c23a62f3a-a699f776748mr392150166b.46.1717684263773;
        Thu, 06 Jun 2024 07:31:03 -0700 (PDT)
Received: from localhost (host-95-246-50-43.retail.telecomitalia.it. [95.246.50.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8b718eeesm14268666b.218.2024.06.06.07.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 07:31:03 -0700 (PDT)
Date: Thu, 06 Jun 2024 16:31:02 +0200
From: Matteo Martelli <matteomartelli3@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <6661c82633d84_2f517370e3@njaxe.notmuch>
In-Reply-To: <20240522164722.954656-1-matteomartelli3@gmail.com>
References: <20240522164722.954656-1-matteomartelli3@gmail.com>
Subject: Re: [PATCH v3 0/2] ASoC: codecs: add support for everest-semi es8311
 codec
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Matteo Martelli wrote:
> This patch set adds support for the Everest-semi ES8311 codec.
> 
> Everest-semi ES8311 codec is a low-power mono audio codec with I2S audio
> interface and I2C control.

Hello Mark,
I've just noticed that this patch series has been applied to asoc/for-next and
linux-next/master but I hadn't receive any "applied" reply mail. Is this
expected? Just wondering if I missed anything in the process.

Thanks,
Matteo Martelli


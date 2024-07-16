Return-Path: <linux-kernel+bounces-253539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEB59322A6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 11:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B1CF1C21375
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 09:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA3E195FE3;
	Tue, 16 Jul 2024 09:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R/UfVuhj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40695336D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 09:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721121794; cv=none; b=qFwqA7a2l+3LXYeF0uC7L6m9VUSpooQ4Ym9Y0Nrq+kyckMVlOmqTUZxCcqVKyJ1Vc/4Za+fnEa15SQHO2YHC0q+41i/06reMPQXlmcMW421FOyziLhPctL+vd/s1dnf0R47UH00yKf8wNAPW8TpRwANQgOxujk+sHS82uwoskrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721121794; c=relaxed/simple;
	bh=CzFdLt4JyYTqsVUjD5gJPS9k36mdesCvHYroK/V5ZtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p2/lB7SuAPU8HAREtAqNAdUDBZisqfSnXRtwx3JNwRdpSuSgCB1T/FsStYvhdrisFowW4BV+X/9p0EmXz/cGeP7bPz0ZjT5HLOKDIu7lcb22qgDlckmXmX+QUuhM+/Jame5s6RRfJgGre8+XJvAhdRARnuY+t4RZrVdq07hlTp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R/UfVuhj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721121791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jEWcjUfhaYfxgYbbLyYUl4A1hHh/hCaPzqQclrhnJvQ=;
	b=R/UfVuhje/zUBMpW06jPzDSPPTmIkF9zlklQAqWcFBA3DH9d6kiaeIvKSB2kxkmBwvDeox
	WyvQZwhjgGD+v8RFbnvmspu3Y0NLh7Y/oEIeYE3ck44OyL/dM78fCNIDJff55XorCi2jWc
	VHqaPkWiTqEHQ3nNDtu/L2AfQ0hVgak=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-45SQ64VDNGqtPY8TgEsRIg-1; Tue, 16 Jul 2024 05:23:09 -0400
X-MC-Unique: 45SQ64VDNGqtPY8TgEsRIg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-52ea249d1c9so4997273e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 02:23:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721121788; x=1721726588;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jEWcjUfhaYfxgYbbLyYUl4A1hHh/hCaPzqQclrhnJvQ=;
        b=CDtQcGZ/Z2axUO3JtFxl0vk+rMjIdiazDfyUZ1bz7162zpL1HMx5WKabZ17eftxAHT
         Mc+5xYQQY739UnCnS2qZZ5hCPhlfD+USI9Xi3jKU177J5l20h4sfiK5sxvUdogbfktXv
         tXbFQjX9JogXXF8yv1BFKw7ZOVWKfs1dKRcuWjW4D+HRPY4jSEOMeMVDFecW1FIM+vgb
         Mi+imJC7beaxSUleyEHFrIlfJ5kmx2qz6EK+9yBsjngp9fgVPyrOlOwSL1f0gYQ4zEbq
         dCiXTwq0brVn9/TW66gVh9m0VacWXIbCM4/MzBjrMFjhGMKkomGauT9nuLYO2ruregA+
         9S1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4AVZ9MlsmUxkiffoL92vdcb3LhR4N3r2wveqLr3R6fl1+kSGgkFDEY+cWsAkb0IukfoM0gcVaW5WrMjhDHkYoF8g9TtWHuc4iqXmh
X-Gm-Message-State: AOJu0YxNx9jAhweBqdbY0bfLvorlaTk3ag/Kk1JuS92auBopBnYrmuQI
	8dZ6KFT/TAXWdRzdAP98aN25Z6Up7F5RLm53/k5X1MUuMVAtZISfQYVjFFc6OQO6OSfCJWNSSxc
	5yT3g0edtYtKYre3EbS9pl6vW5dtKW9JlxiJNWf8sFN0nWI18SPDhQK+pVuy6jw==
X-Received: by 2002:a05:6512:2355:b0:52c:dca7:c9bd with SMTP id 2adb3069b0e04-52edf02307emr978594e87.30.1721121788344;
        Tue, 16 Jul 2024 02:23:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJncws79XRTzgOf8xgugqHTD+bGgIyLMXZZ6UgcB51t2NtKZbOgCoVScjh6VuIXGz7ft+mMA==
X-Received: by 2002:a05:6512:2355:b0:52c:dca7:c9bd with SMTP id 2adb3069b0e04-52edf02307emr978574e87.30.1721121787935;
        Tue, 16 Jul 2024 02:23:07 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5e8609sm288336866b.94.2024.07.16.02.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 02:23:07 -0700 (PDT)
Message-ID: <f5bf195e-7a46-48f6-960f-f187be0131d5@redhat.com>
Date: Tue, 16 Jul 2024 11:23:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/1] platform/x86: asus-wmi: fix TUF laptop RGB variant
To: "Luke D. Jones" <luke@ljones.dev>, platform-driver-x86@vger.kernel.org
Cc: corentin.chary@gmail.com, ilpo.jarvinen@linux.intel.com,
 linux-kernel@vger.kernel.org
References: <20240716011130.17464-1-luke@ljones.dev>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240716011130.17464-1-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 7/16/24 3:11 AM, Luke D. Jones wrote:
> Changelog
> - v1:
>   - Fix subject and fixes tag

Small remark for the next time you post a new version of a patch.

Since you already posted the version with the Fixes tag as subject
before, this is v2; and ...

> History:
>  - v0: https://lore.kernel.org/platform-driver-x86/5c4ef8d8-2806-5bb6-2946-368cf1ebbac6@linux.intel.com/T/#m9ceb12d4d135e28e71e4d74ecc9a78083a6c8745

This would be v1.

Regards,

Hans




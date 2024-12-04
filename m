Return-Path: <linux-kernel+bounces-430632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 778B39E33D6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52ACE1626F8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 07:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0BB18BBAC;
	Wed,  4 Dec 2024 07:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZmK6jvMD"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862EA188737
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 07:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733296009; cv=none; b=RZSEqKbyrype6kOGprmXtEFtQK5q7nFHlR5jYd7dvWH/aD6KvdAzMf5GGmIVe2aNZr/JJtGkTIaq6nQQiKYdigy94H2quPdgnqhEKB3slPk3izrBMXjkwfucu3fACMKnFUU2beolNgRhygYCpVPBo1jGz44EBHcw/V6LgNIQ3Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733296009; c=relaxed/simple;
	bh=cGlfrmz+NqreEMAIegTgQf/lwOLc4c3SnJaIudI5nbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BErAPEj6RraAvsom/n9W0OUcMe2xBn6DYRvTaWa6SqSAuMWI+6QnSnLh6F65BkSUMmzdt7imCeVsC7igFIi0EhZ1GV+hScMk8JwRwRekMp+/DsdEPgJzblyIIFOlAESsmVXfF1yQ24S3GN3GkCy36Rqa5Ee1PrpCiW24ximLaiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZmK6jvMD; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7fc99fc2b16so3827523a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 23:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733296008; x=1733900808; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xA+pFDHJg3JhuJO3t6B1WVFWzMnLuBLDIJWm/HSdUeE=;
        b=ZmK6jvMD5KpCtMToxjn2rYrq+ODnsUw+YkXnToMzFDJCRlvCwYmK9gmYVnT9jEh31n
         amE/LfIVIFapl4+AZ8lXH2ZsD/TEGL+2EJERVaJ/eFoBU8jRPLV/5p3qAe0Rg+k+kcDZ
         ImfdmS//e2UXActguJNrCYwSNLelF5S26MxmIBgMsh6X6WEVpOS81BHkKfmYAv7LawUQ
         62nx5nny2xRX/1FpVc1I3Jk61dEVHwsJ5Ty+eu9z3fDlllOKhJOIPWa2kE6tA489MW1J
         n0NQQZz2N1pIcJ+ea8P/ycqBi+Rw7oroLf/QhXy7zHK7e+eYmPpdhlG77oH1yzFQkwvc
         D5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733296008; x=1733900808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xA+pFDHJg3JhuJO3t6B1WVFWzMnLuBLDIJWm/HSdUeE=;
        b=JXfYqhHiVWJXygUjDVDW0eMC1kqe37XMW/EfHok3goaNhVmkaGz+9KRg47i/59Gen/
         VYUI5mrIW7THjk2s5p7mJsZLey4sftVycZ78taIZHL+SYlqyEfaYFFKGhh/AfLtBWB6S
         CkccMd4ZMDyoI8Zq+PL1TdAaaM6WSQOOadq6CUg8k4OBb6urAzr9VpEEZX0MnYn9Lbse
         pJJWi/jieRj8qTOVrdMQ66TL2H/fYVHVqp9qs4bI9zgivD4JsKisFAZ52b8wRDzgPbGV
         1z8fT4rzx+96BHBNnWwEA6WdJKaGWyW8741oTlqViQrPl7Rgx8L0wtSs3VVLD0lPJSUX
         m1Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWEqCsUlqtxGq2dv8R8KV04kBoS7wwE6WH2aVvTXFqFROcAcsqiEmkGOa9RiU2m7Y7eMwLcI7SbkONi1nY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvAOxbnQE1U63mvihSYFxAp6wxmzWHtUj2zpqPGa+0DXWk3K7G
	3CgwOLI3i2kj06fXjpHxeWsKDzXGjafChB/5Z8svQn3FC3G/wNdRasgErMFVKww=
X-Gm-Gg: ASbGncvM8VHiENkvnOeYKiRUU+zK0AQcJK7wPnJFMRE8y/BWN8fVQ3p2RAVnYGGvzzm
	FFjjTAKG8q8+MXpPs7Y/MJbSadx1nm7cXq2DtWg6mZzJGUCzc1rH726AIdRdNzmJEKpysaY7n93
	sK3WaJIMcuKtxSfYYvio2QYS8CNdbPYStAif2Dtchk1CceVbLsAfuZnJ75/20W2uMgHX8HdecB0
	juB64txIFnc93qzyAJHAH+zBMllKI7HrJFXfD6c+b2/7voFJ14H
X-Google-Smtp-Source: AGHT+IG+WEflcRy0H3XEQNdVIydDsgK82mB+3ttGOJT8u6l9qXJ9IQZOOl8bI5c8OzLfA7MXQ9iRSw==
X-Received: by 2002:a05:6a21:999a:b0:1e0:d766:8da0 with SMTP id adf61e73a8af0-1e1653f2427mr7360540637.28.1733296007968;
        Tue, 03 Dec 2024 23:06:47 -0800 (PST)
Received: from localhost ([122.172.86.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541761246sm11705852b3a.12.2024.12.03.23.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 23:06:47 -0800 (PST)
Date: Wed, 4 Dec 2024 12:36:45 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [PATCH v5 2/2] cpufreq: airoha: Add EN7581 CPUFreq SMCCC driver
Message-ID: <20241204070645.4paiiaj5lsvlohlq@vireshk-i7>
References: <20241203163158.580-1-ansuelsmth@gmail.com>
 <20241203163158.580-2-ansuelsmth@gmail.com>
 <20241204053211.6gdogcpi4g3eavw5@vireshk-i7>
 <674fff09.050a0220.293594.24be@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <674fff09.050a0220.293594.24be@mx.google.com>

On 04-12-24, 08:04, Christian Marangi wrote:
> The idea I prefer this is to save a few CPU cycle and also to prevent
> bad usage of the CLK if anyone starts to use it. Returning 0 from a set_rate
> would provide bad information. Or your idea was to declare a set_rate
> and always return an error like -EINVAL? 

Returning error is not okay, as it will make opp-set fail eventually.
I think we are doing the right thing right now.

-- 
viresh


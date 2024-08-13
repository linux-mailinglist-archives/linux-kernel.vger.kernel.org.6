Return-Path: <linux-kernel+bounces-284284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9344094FF55
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEB861C21AD4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FADC13A87C;
	Tue, 13 Aug 2024 08:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aF4IFUFI"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4B147F5B
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723536412; cv=none; b=jU7qZZX/WcAOupGTsqlRuGvXENojpXSf3or76KrXwxpBTISCuSMvqvhXGzMmUO1iaIo43pKPUmkFfbucFvRlOoqcoNnnwdaxi/lI8c0iCssmB0cC5VOx0iLrMT//fMhzKuZyDoA9JbH0vW0jayZyi5+Wfa61H4omN4a6X2DHc5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723536412; c=relaxed/simple;
	bh=BvAqtCFIBrKq32GAj44YKOBecH7LTrOIZkXTL2CA6m4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLZ+8ZgevxeYId8enXgtz6B31Vbd4EK01VPC4CHdULjryYqJiMeq98VhKP3MMMkPW00jS9K0Oc1NgwZnsj+uIb9C3fwKmxjYscMGbGm3x45ConpOYoseySXEEHhW5eWyiGOQlowKK5/b3AWs/QJrTKmEbDjqv2bLIdh3lkaTgSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aF4IFUFI; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7de4364ca8so549198166b.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 01:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723536408; x=1724141208; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dEbEbBr03OYuwYP8f6MOR5iKrAH0xwcbF5rG1MTVpOw=;
        b=aF4IFUFImW8cQNTcWhJy7wtjXqkQsRpUSA5MfvMMQzQPlpRYixRXjHFa17Xo25YTQ1
         40lSmQI/CdvaGM1fUniKMywY+kxHAr4laq8R0UiZ9VVPXnPi22KTzwvryuCvX28IBPL6
         guNKBC+Od1I6XW99JICHL4ZY9c4DWWy7GrOqpL19hikBXM7Q1WTIUa3rIhP+AodsaExm
         bBVls51F+yff3o5XQqcya5cNuA9z6mGQqpmM7SCg3rOJLjhPs/6MYAabxlRf6n3wR6iu
         GZqlpsJrlkT8m6O4cWwGei0OGQn8VkZHTeDcItJ9CEv6GVTMJWEgch5ySc7PCJa1s+St
         ok6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723536408; x=1724141208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEbEbBr03OYuwYP8f6MOR5iKrAH0xwcbF5rG1MTVpOw=;
        b=TwPzaWY/ytmRaOArRv2n7z5lHviviXHj9PhMvxswqG1VMFvDGVSBDsofDn6hEbVxPi
         AZyNQ5+wdcRKLAWFB/mQ8Op8L2He7OeVexyvPuthslrV0BPW2T1T/1+g/ttwqTeGBhgt
         uzBSqOM6tiqBdWOlty1PY1SoUkc9ekx6J3JeZ8Z2SWHQCB3Map0dFnPVfAalCmB7s/iw
         RqUVCPi0ghhhI9dctddlvQB+VjGis6BQKb8+zLPT/UWgbAZHrynk1tKAMoC33jqa4rIN
         mbIcTV6KiOgcRFcE7OpbcqKaQFfj3MgSKZzNrGrjQtem1q86ql3m6viRClqnp9DC4X0V
         oJKg==
X-Forwarded-Encrypted: i=1; AJvYcCXw7meff9M4g83+oYcceV1EtJAhqParHgzp75s3wJzl4dmuROqvMo+nIVCN30KvR8KL9G7CiGY2shy+LqtVMu1kIDJdUW/D9EGMxpHz
X-Gm-Message-State: AOJu0YzQ7lasBhAJu93fkp5BfSlDlAPNY5K/ydYut0uXYCQKWxRqBcXp
	Bso+cAQZJbH4y7TfKmt3Q8y8yQP9iI65hoFcwB6xhtnqOdSFg5QRvkQJ5dPSBrk=
X-Google-Smtp-Source: AGHT+IGkQmluegEvOCR04zQGFNMMJOXbaMawbLU7Q1dimfbs9OBxlsra50k47SxAe4Dnl7gf/d2JpA==
X-Received: by 2002:a17:907:968b:b0:a80:f7d5:addd with SMTP id a640c23a62f3a-a80f7d5ae9emr76749866b.13.1723536407834;
        Tue, 13 Aug 2024 01:06:47 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f411b105sm47786166b.103.2024.08.13.01.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 01:06:47 -0700 (PDT)
Date: Tue, 13 Aug 2024 11:06:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jan Kiszka <jan.kiszka@siemens.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Diogo Ivo <diogo.ivo@siemens.com>, Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com,
	Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net-next v2 3/7] net: ti: icssg-prueth: Stop hardcoding
 def_inc
Message-ID: <42da6d34-e4ab-487c-8079-877d96d83ad9@stanley.mountain>
References: <20240813074233.2473876-1-danishanwar@ti.com>
 <20240813074233.2473876-4-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813074233.2473876-4-danishanwar@ti.com>

On Tue, Aug 13, 2024 at 01:12:29PM +0530, MD Danish Anwar wrote:
> The def_inc is stored in icss_iep structure. Currently default increment
> (ns per clock tick) is hardcoded to 4 (Clock frequency being 250 MHz).
> Change this to use the iep->def_inc variable as the iep structure is now
> accessible to the driver files.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---

Thanks for breaking this out into a separate patch and removing the unused
spinlock.  I don't necessarily feel qualified to review this patchset but I
didn't have any other issues with it.

regards,
dan carpenter




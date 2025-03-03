Return-Path: <linux-kernel+bounces-541156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B400A4B95D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 09:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDB2D3B1CC5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 08:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5B61EFF9F;
	Mon,  3 Mar 2025 08:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mSRy+ul+"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2791EF09A
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 08:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740990516; cv=none; b=YyhNI3wDM1tKOgD4KBkuzqrmNQk890zztGyFRIY+tkATkL8wZn6UL8IcXFc4Ubbgl8eOt8aDVp9ztW4FHo+ZcBtEVRZstmpSkgdN7LnHHgtB/wkVhGBcR8fIJVEKuL1yTZPWA2DZ/l0wBqZX5JLtNyOZ55tQl1MWM6RFQxJ8Wxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740990516; c=relaxed/simple;
	bh=17WU/vH9aHCfGSpScMmdp2rp+45c0QI5B8X33drirlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZ6/KJxbQn1Wq1Oit1r15ww3AgOq7SgzE59MZbjmUwuuCBMuFN0ieVDCGc897xNhv74apEEdrGUq1DCMHU4o89szs5rnZuqavd5HJ5SsKClSZvLePgP3/MIfr0wsI8boa5/+NId5Q3M7Syc/rLRU7Qla6rvFERqJtH5oDtGx7Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mSRy+ul+; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5dca468c5e4so7283173a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 00:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740990513; x=1741595313; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3GVS4Gx/rVoQ468as/SRsaUG7WhV9vxUwVHJFy+CZ1g=;
        b=mSRy+ul+qpvSr/yDInfA/iZF1XHAHsoejAB5qBP6mI7zryP1CLNvjWrPXszFRm+AZv
         tSooa1JyE2H06PCzI5pzUUTVtty/ne/ouq1/TVRE0Fr06s/kjukRqrfG9iTJYwUbFK1+
         DCwZlmDCM9pZCJJJ12kkUqm66/CzojVkDhbmKFPZEVbr/g2EchpgTYhxhr+nq1eaaIPC
         2Q34YbCPd9McWcFL378WXhx/0nqY4TG7s1fg+Pffp40bsCdoJzeahr7w8m6ow/FVf8CD
         19EMMeozA7Jw2FnTyO1nRI56AKMuy7FaCQdKcgLRb4i2JbnPzIWGFWy26asgP7UGMd1p
         vrsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740990513; x=1741595313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3GVS4Gx/rVoQ468as/SRsaUG7WhV9vxUwVHJFy+CZ1g=;
        b=Sjvs74cE9mCRdno0jhcEPDDkbX8SL59ws0yP6JdjKok/n77ug702RpWXh7Jxn3G/fT
         t3Bw1/DQVy2s3Gc4XzRojAgcIH8Ghk8gE5tzwDlKOSobFExfOX0bzug+i5YI4S2QpCd/
         uCTryn5hhRSGoElhYreUydCCplY1GIaav7wGn/xjUE41NMBMOQRyzEPbXgd6k5glYRQ4
         JvYS/0q5BG2Xt4flO3fZGvrewWHLYuOqNqOK6aKsDeIlkaJkwAzAr1gSr9cw3taQf3XH
         4kRK8qvaFBmO35Z1rZJUIwyNS71gylaU4gc1vrvCVOrLCELF1pYkwFJx3UTlH/zVM/ck
         ahYA==
X-Forwarded-Encrypted: i=1; AJvYcCUUmx5aNMibo/6vVSlVVXz9RcdYeYOkb7xuRMuvPewC2kVo5K8s+b5+hKJeCWD9sjwX3dbfAedUmr1BYJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxOk5uhPiWJbFBjR4uuCEF6qfhGjL2eEDO6/HE13gvwk7g6i8w
	0VWro9IV0bkGMzyg6nn3n7NXMD1lJ9pFAHLjKXa5yJQ58K2uHfIgJ0iahQA+6VY=
X-Gm-Gg: ASbGncumgg9cXWEOmSEgwmdz5lcNM9MnYUvXDvQyy1dxuJ8sZHPqMiETt1Vs44AyQYA
	ugsFm2KElHJY8e07YB2nJmOYDzeFsUqtR7pa//q5UXSA1Lzkm8y0ZdPM0A/RjUfYWrY1BSDwQG6
	B3cr0b+O0lexGaENM1DkMfmMN47Tf88sc1AQtJFUM1BD9/zUY6c0cQ5XAfYB4eWjF9a3V4J0X5+
	xSf9h45AqlQlBF0/i5YFOauR6fYKVRI3Y7nA3ULL+7qDEdjDoYyW2LZAlFgfZ+UGu8/yvt5er0p
	v0BZ1JrWSkBSxekf6E/Wc/VDPT3DAm29JVaEQfLmmUigp+d6hA==
X-Google-Smtp-Source: AGHT+IGw3jWZzmT57/dnLc4o23VsN9vptXaHinStqoaL1K9VwYGdN1PlwZ1rxWVXdJbPl66BSv46Bw==
X-Received: by 2002:a17:906:135b:b0:abf:3fb0:8c01 with SMTP id a640c23a62f3a-abf3fb08ef3mr1023217366b.6.1740990513299;
        Mon, 03 Mar 2025 00:28:33 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abf7a3ea634sm145845666b.174.2025.03.03.00.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 00:28:32 -0800 (PST)
Date: Mon, 3 Mar 2025 11:28:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Ariel Elior <aelior@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Manish Chopra <manishc@marvell.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ram Amrani <Ram.Amrani@caviumnetworks.com>,
	Yuval Mintz <Yuval.Mintz@caviumnetworks.com>, cocci@inria.fr,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND] qed: Move a variable assignment behind a null pointer
 check in two functions
Message-ID: <a191bd33-6c59-45c2-9890-265ec182b39a@stanley.mountain>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <f7967bee-f3f1-54c4-7352-40c39dd7fead@web.de>
 <6958583a-77c0-41ca-8f80-7ff647b385bb@web.de>
 <Z8VKaGm1YqkxK4GM@mev-dev.igk.intel.com>
 <325e67fc-48df-4571-a87e-5660a3d3968f@stanley.mountain>
 <64725552-d915-429d-b8f8-1350c3cc17ae@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64725552-d915-429d-b8f8-1350c3cc17ae@web.de>

On Mon, Mar 03, 2025 at 09:22:58AM +0100, Markus Elfring wrote:
> > The assignment:
> >
> > 	p_rx = &p_ll2_conn->rx_queue;
> >
> > does not dereference "p_ll2_conn".  It just does pointer math.  So the
> > original code works fine.
> 
> Is there a need to clarify affected implementation details any more?
> https://wiki.sei.cmu.edu/confluence/display/c/EXP34-C.+Do+not+dereference+null+pointers

This is not a NULL dereference.  It's just pointer math.

regards,
dan carpenter



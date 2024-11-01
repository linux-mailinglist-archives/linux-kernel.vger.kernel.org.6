Return-Path: <linux-kernel+bounces-391856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 508269B8C81
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 09:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 074EC1F22B5C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 08:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22DF156256;
	Fri,  1 Nov 2024 07:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u2/35Jx9"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019EF155C98
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 07:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730447990; cv=none; b=kk2lR8OfJbKm0qug+YyhHWUuomQJUVkcrWHsQrPNNuDpmBL3qNSq7bZ/XEM42ANYqyKyMeZPnjLOqZqImWe+7KteTE8Wtp4N+FPfBDVZFcIRSwNAnM40FeQ+qXK11dWyn/+dkNp4/jN00oXHhzwbMx8iJnL2H5YP4n9aH/yDl3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730447990; c=relaxed/simple;
	bh=SfUPFE3xJpp2hT8t6PwPjHzFXis9r1KFqiu5s4r00dI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sS0K9O7CvlWxPdGYxxHzSVjOLM+9vypGIW8D0ZFBpRC1treFx3EDZfg1KvEjConU4h6XOwVjsogdqTLaFl7D21PLn5Ctjk1/gJIxn/LEuVgz4PM3TJvM1c5of58YRY22MCYOB7/cYBIyrGOEAKpwppV/jzNkv6IsGSqlrFlqve0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u2/35Jx9; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fb3da341c9so16797121fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 00:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730447986; x=1731052786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1P10h7U5Kb7vQrjUsh/orW72yVZ+j6ys79C1Uvfngxk=;
        b=u2/35Jx9X7vyOZzwGINNlHamuXmBPaJrZlUw7aQoObI0GlU/JpDpSU16Gh1/jUOHQU
         WPzjgrW4QMrB9I83/pAvf10Jv+bIInD+/7zi/Rz3qAL7idveLSuFZ1BH6h8oMfXiyFvs
         R5DzQaCQue7+E0mo17Hll1oyl0GIfN9br9UfwaLnAMcSXEJlIUXfc5R9kGJGuJEjMc2c
         r+p3QS60dJtoM/JxWLzsf8eFjDOpkS2fzOcIuQsmne03tXjoOj/aTKtuFQLV/elWhDEw
         n9VDOsGieJA19onlAhZXgC1iDSmg85KJwWTu96YZy81pHVHF5NH1ySBteXfwt0CmCc1J
         OtTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730447986; x=1731052786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1P10h7U5Kb7vQrjUsh/orW72yVZ+j6ys79C1Uvfngxk=;
        b=SSM/8renSevJJSu7O0Gkyz0TObpdy4AuFMgpRBPNNyZGCAiXOqlyRZrF20ERf95EEJ
         GDorbHXClbopxGgOnR1sWUx/Vamd3VV8jospijsq/uFfG/7aXWaBYtPQ/FiNfemEjxU9
         aaNy1Oz3OoFdekLxYMeGfiGfMpGRvL0sC+SncOnWsUjBADqywENiK3ZUIwiD5VsWn6AR
         JVSSFDIqt2ytDwyA4QErXcg1eKBVTSoCght7/+gJeW/iEkqp1TIZINZcU9M6pkobTCKa
         Grl57qoMBxBttElOHNAIT6XiaHXlmRgzJ64MA2bLQLOPdJU8zOxZZeVCCR+jrL25+lpe
         +VWA==
X-Forwarded-Encrypted: i=1; AJvYcCVAkee78+dCgXIweiP4Keb8gv33quqCfrJEAhhjKepRK9M66jZOGJv/bEHLjfxjdQRXSgUHs20gqjGTNIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL7sMhYJMLqfYDcmP8PmzP37Y/Q49wPb9gdawcJrJbecvU0K50
	POGIY3x2/Z0DHYg6lFl9gnDLo+Si8SB9XOiI7IfupzvJ/M3TpWLeDHJV1F6N2sI=
X-Google-Smtp-Source: AGHT+IGQgBtNOZ+VYXmf4gj/Nt5psxDUja0JoJoz8aG2LnVpbuqmsOow8kmGlrwIGKa4Ci+UGaN96A==
X-Received: by 2002:a2e:a9a1:0:b0:2fb:5a7e:504f with SMTP id 38308e7fff4ca-2fedb7d925fmr13781771fa.35.1730447986000;
        Fri, 01 Nov 2024 00:59:46 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fdef5d624esm4838921fa.38.2024.11.01.00.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 00:59:44 -0700 (PDT)
Date: Fri, 1 Nov 2024 09:59:42 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Amit Sunil Dhamne <amitsd@google.com>, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, gregkh@linuxfoundation.org, 
	heikki.krogerus@linux.intel.com, kyletso@google.com, rdbabiera@google.com, badhri@google.com, 
	linux@roeck-us.net, xu.yang_2@nxp.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v1 2/3] dt-bindings: usb: maxim,max33359.yaml: add usage
 of sink bc12 time property
Message-ID: <kw6czm6ekl3m6qcqt37vgwaz4wu5zllfua4sjoif66lg6gt6ns@6seazbeefnhw>
References: <20241031235957.1261244-1-amitsd@google.com>
 <20241031235957.1261244-3-amitsd@google.com>
 <r44xdvk53c45bhyvwhy6722vj7wttkhfesta3ty22kkt6nfrtu@vcooujz3ywlj>
 <a86c8317-16d6-4aa0-b8fd-5c83b1445212@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a86c8317-16d6-4aa0-b8fd-5c83b1445212@kernel.org>

On Fri, Nov 01, 2024 at 08:09:52AM +0100, Krzysztof Kozlowski wrote:
> On 01/11/2024 08:02, Krzysztof Kozlowski wrote:
> > On Thu, Oct 31, 2024 at 04:59:53PM -0700, Amit Sunil Dhamne wrote:
> >> Add usage of "sink-bc12-completion-time-ms"  connector property to
> > 
> > There is no such property. You cannot add it. You did not even
> > test this patch before sending :/
> > 
> 
> Sorry, now I see that's the patch 2, not 1. Somehow I thought you
> started with it and I got confused.

The question is why patch 2 generated the error even if it had patch 1
in front of it?

-- 
With best wishes
Dmitry


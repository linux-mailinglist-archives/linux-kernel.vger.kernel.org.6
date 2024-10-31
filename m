Return-Path: <linux-kernel+bounces-390423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D209B79A9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76AF21F23719
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 11:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30CF19ADA2;
	Thu, 31 Oct 2024 11:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hz3vh/+D"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B1419ABBB
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 11:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730374071; cv=none; b=gaYgc6b3mi8o+JeDvH7EB3wjTH+D9hfYRYsw1Si+kcjFwXo9wggVhN8HwIBsySK9H6sg8Q00unGSTzvlBEKybyhp9MzcOCZGeOfCTGuuKyw48K3u70sXRjJ+lfT1BK6MU1unHhSNvu+8t8SBtOedjqz2oVXNkQz7Zo7j6dE6Jtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730374071; c=relaxed/simple;
	bh=2/wxx2yPHeqzUl3bK4IWTgP7OiPHmrV9sMpSAgHj9dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSHo51qBpAoMcnOBh2DO5mXi330nqkm+o9usuyAo/Y9NGtTjxMmzwhdyGi+Onvx8LvjpcayT92eehIdQE6Aa3yAfIfjE+eLD5tmwgYW42Ve+nzMRggX/u4BAJ0MjCvto3wtQarX9lAMWhZKQAfDkouuyThZCRMrz+njTuJHsgK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hz3vh/+D; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d47b38336so657403f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 04:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730374067; x=1730978867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Qinma5kqYmuHBjZm6H5Vna/9c51/QTVcMYek7K4+Gg=;
        b=hz3vh/+DULH61ZS/p5Cp2thML0yxKqd7e73IBuRXFu6wKCViP6WlA2G4vqhKc23MjV
         zqcd+UCDgVgp8ki0eeE2tYUmBYHtybT7IaeZdMIk6BnGM7z7JcLOCV8MtY2I3G6TmEYC
         Q1DdLBCuKkV2lJXwuMugcdfFYOwxjQfy+OF3kgQskpb3T/h6Q3SDiQGe3sNr0QRCWI4l
         YSHxCwvQJAUnTpMdyqbPeg+3lQd5Vs4hJsWl9BX+eUp7CsW3elwE6xFCt4n4KcdO8T7r
         QBE1FboIr+l8GpyI7FcQ03hSMKOtoWo/qQ0BK2iMEdMuKpt3XEQWPpEI7ua8d4Hu2iqJ
         oqjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730374067; x=1730978867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Qinma5kqYmuHBjZm6H5Vna/9c51/QTVcMYek7K4+Gg=;
        b=q3JUkAQsiwnr0cFbPQPeLAoZeJ+fXkIM+wXGw6WXoA+KN66Brgwn4U/XKjNx7JSb2f
         geZ5UATu0GMnWC8X38puAs8p7t46XNFJAycGwNgUHiUJJwSGSthZUPkQc7gNkhoQx0kh
         mS4PVKzfyG3tC1UgGvv1w0Bo0wnN1Zk8guI7MNPX6uHMCCmpP9ibpnRO5oIem4kD3X9i
         NQiZklC1RoRB9EQ5luYCvgHD3QWs+WEMXvL18p4A7cD4zPsS+3t07brtGrpf7PuVGRcv
         x+X15YNXxzW75iXEfqElNikUxzjxi8E9+4E0sd2saIvaFNg2kV9vrmFJZ+wxXc7ebats
         re/A==
X-Forwarded-Encrypted: i=1; AJvYcCWOb7HTXfc9FVQDzVBF2jpy/b02IeDVYuAHqgNQXDG8O7le3S6rtHMbdBD+zC+8yJr2GOmLtdy0NiQcWiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUT09NO519bBajvBVQQqW4NCAzZTUmJsKUpBUBFCyy7xGzMdbj
	zUUevoz53r3UAAuieGQSB9rMbARgmJes/giwKXbP4ffuJ08e6U+nVAbt2vuGpL4=
X-Google-Smtp-Source: AGHT+IHMzU32/E5p1uwxhDrq7bFwkszQjYOIXlfcx9OzbVpxpXnCoF3yBkBjLJDocKcQhGQ24Jv1YQ==
X-Received: by 2002:adf:9793:0:b0:367:9881:7d66 with SMTP id ffacd0b85a97d-380612008e6mr13984567f8f.41.1730374067469;
        Thu, 31 Oct 2024 04:27:47 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113e6b5sm1847280f8f.88.2024.10.31.04.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 04:27:46 -0700 (PDT)
Date: Thu, 31 Oct 2024 14:27:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	lkft-triage@lists.linaro.org,
	Anders Roxell <anders.roxell@linaro.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Linux Media Mailing List <linux-media@vger.kernel.org>
Subject: Re: next-20241028: gcc-8-defconfig : ERROR: modpost:
 "__aeabi_uldivmod" [drivers/media/dvb-frontends/cxd2841er.ko] undefined!
Message-ID: <d3903c31-21ae-4ffe-9969-6faa7e430cb5@stanley.mountain>
References: <CA+G9fYvvNm-aYodLaAwwTjEGtX0YxR-1R14FOA5aHKt0sSVsYg@mail.gmail.com>
 <456c79d2-5041-47c4-bed2-44d257524ddd@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <456c79d2-5041-47c4-bed2-44d257524ddd@stanley.mountain>

Arnd, can you take a look at this?

This patch fixes the build, but obviously breaks the kernel so don't apply it.
I don't know how do_div() works or what changed though.  All this code looks
ancient.

regards,
dan carpenter

diff --git a/drivers/media/dvb-frontends/cxd2841er.c b/drivers/media/dvb-frontends/cxd2841er.c
index d925ca24183b..e3131f5c6708 100644
--- a/drivers/media/dvb-frontends/cxd2841er.c
+++ b/drivers/media/dvb-frontends/cxd2841er.c
@@ -314,7 +314,7 @@ static u32 cxd2841er_calc_iffreq_xtal(enum cxd2841er_xtal xtal, u32 ifhz)
 	u64 tmp;
 
 	tmp = (u64) ifhz * 16777216;
-	do_div(tmp, ((xtal == SONY_XTAL_24000) ? 48000000 : 41000000));
+//	do_div(tmp, ((xtal == SONY_XTAL_24000) ? 48000000 : 41000000));
 
 	return (u32) tmp;
 }


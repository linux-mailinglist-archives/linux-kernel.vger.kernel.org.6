Return-Path: <linux-kernel+bounces-187661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D54CD8CD60C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 16:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4047CB21373
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD9F14B966;
	Thu, 23 May 2024 14:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sUafcP7X"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F99929CEB
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 14:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716475461; cv=none; b=MAxDYJM/ruS1xPxU/KDR2EkQh8uT/4naSKgPgz4PgJKtLWr1hocZGOZdgHsZMgiPZiv8KcGFyl/e5k9Q+3pBh1hCTSO9KbYtIwf185AArYm84HEA5zZwcFbwqdjwVNw4ImdEwS7BOi0uGPoMFTQZsf8lpgp26K5oINdaJ6T8xoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716475461; c=relaxed/simple;
	bh=CTkFcBEe+lA0saa+37DFgtuerxcdKMPPNDW5UJ0eiSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+Kt2dW0s1O3Wa3BsKRUVpHGYqhjNhMyeu9PPcY1M7LLGCryd/5dUTq0yyeLsdl7oiJx6TgiAsKmppO7Bz9rL1yl4Tkj7wIAjpDcupV/gsvwlCHkiAnWccwEU3UQctgD5OHQGDIfjmShxPsz54MQi3daXG/97odx2HKfEMmcRNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sUafcP7X; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42101a2ac2cso8494245e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 07:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716475458; x=1717080258; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EflueoXTaQwLTE/im9nkFXYa8es8iL3v6VZsuAhHrIY=;
        b=sUafcP7XDiOnz2QTr2/BmzfkY/+EV4X7AfOG1mwX5U7BPKXqwBquUvlj7gVSFfRMkQ
         uimj0Hf2Ppqn39ANMnMrMc7BJodw4OOklqU3iUkIokwa8EmS0AotwqXW0FW+2bBfxyE/
         MWjjC5/nZACWjeYCW0iQyQm57ntLp8qIDRoaof6E+QlMvS+/U0jGeIRV3Uz5MWSPfumQ
         XYY35zlkM7DcmRmw2h7QqFDFv6BDJwUieQuZfQCp57JoqDt/HD33zVmlYM+oXCfySshe
         sbc2GahQxeSxFoVZGzc4/uCk5JPOKYV8DDN9tk588zHjbKmionZOvKGIgcJBOjaKLcYB
         /Rfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716475458; x=1717080258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EflueoXTaQwLTE/im9nkFXYa8es8iL3v6VZsuAhHrIY=;
        b=raqSRXTgI/gFPw6RX8Gqt62ktGsBp/oxfrmOyryNBbJCTRd5dKT44DClgL2Bvhdclq
         TVNvHSa/Guj9p2W4iRUNemFIotYc6sAfL54bZud2onPCiXoknzNGLx2aE4WcRWsVkOB9
         l6zoFrZwK4ZnFnbybZg25suhGAz0oBwK52+FbiiCm9hZgDwVYV3jKolGH0k2LyzHKDth
         PZfQs0VUodwVHGFJChvoVTuH+y7e0V2+C4gFAhXluiPE2Opt6sUn5ElJYLn5XLL9gM5B
         wPJBW8mDgVNcJjgWXWh7KSAiHHfqwHHhBlSCewGTRwLSQ57rbs0fbLBXtnYBzawK+y5F
         fN5Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+nwhCA63usOPD7uvPZYBdPiyOMoqsRwyTqvAN0cWiof2kVzG7Llf5W04Bcr3mLEm2yz2T6mToDg9oaFACKfvYAeIdCicKkgDWuAeH
X-Gm-Message-State: AOJu0YyOL2HqhhTFTbYWhDH02G/2/3NwCLbZ/gMgON9ewDsqH0IUuJe8
	3Rr4x4Wws6PX/X1sZfBfuLcbG8NJzK+kZOQCPe06rnnfHZivoHtf4khXByZGCFM=
X-Google-Smtp-Source: AGHT+IGKkx7VMsskD3yuGoLQql+31EQW+bCMcF0GvqSoicuAhJyouji9srJuUdiIZnIAxGjg2uDLaA==
X-Received: by 2002:a05:600c:6a05:b0:41f:ed4c:b8b6 with SMTP id 5b1f17b1804b1-420fd3494f0mr40729205e9.38.1716475457414;
        Thu, 23 May 2024 07:44:17 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100ee7f1dsm27249335e9.7.2024.05.23.07.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 07:44:16 -0700 (PDT)
Date: Thu, 23 May 2024 17:44:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Tree Davies <tdavies@darkphysics.net>
Cc: gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/31] Staging: rtl8192e: rtllib_rx.c Rename camelcase
 variables
Message-ID: <75949442-193f-4db6-826c-6f23250c11b5@moroto.mountain>
References: <20240521031718.17852-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521031718.17852-1-tdavies@darkphysics.net>

On Mon, May 20, 2024 at 08:16:47PM -0700, Tree Davies wrote:
> This is v2 of series renaming camelcase variables to meet style
> guide requirements. Thank you in advance to reviewers.
> ~ Tree
> 
> Changes:
> #16 Renamed plist to list
> #17 Renamed npadding_length to pad_len
> #19 Deleted ChkLength variable
> 

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter



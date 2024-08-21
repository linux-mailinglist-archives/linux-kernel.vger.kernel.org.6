Return-Path: <linux-kernel+bounces-296151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5533C95A64F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 23:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8855B1C217EF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 21:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926AF170A36;
	Wed, 21 Aug 2024 21:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DXFh42K2"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C1B1531EF
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 21:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724274263; cv=none; b=QT2ZokihXawOqQ1zr85fq8o4pYwNRm9KXPZqMNHFulaOM/hanw5DJyStxkZY9A+OnqIH+7t8/XMfeGZxjH/Z044yt/uJl1cNMER1xg0zC/W8BDudF8pVK5QLsHz1V5fdMciLgXMy6eS7LyAP0nzNnUwTDrrCOy6dISB5qfAO2iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724274263; c=relaxed/simple;
	bh=SAb4zDtkx0tlEKYJMcHCp3X5xRUof9qOVZxADAha1h4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=biVBxb0qbNJJmUtSVG2+Txy+FKQM+NuIgMX1SkwC5VDyILMG3fOL7juH+0NsMzFHVpNckPTbrE2vrUjTUUYtfXhpxKuW87V4RP03keJvcWSgHh8j+x/3DKyNLRmAGN71JEXjq1nIJY/SMZi1tDTsZaV9wxpPCw/LJf4KsxtyAfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DXFh42K2; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5becdf7d36aso208800a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 14:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724274260; x=1724879060; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bca90P9ChDkgtck0w2Stz/QCYYqZlcBKDKfLWKWDSCU=;
        b=DXFh42K2Be1N/ZDhdvYO9NgLNlgXbreHtEoKiirQYh3FlQvhupbR/vtzQ5+dO8EQE5
         EviEsbrj+pHrNdiBcNuAxQ1d1WlX4a2rnv/4hzz+LU1YF8SSKsYVl38FQ+75VRWRhiqE
         IOJUfBUnEu/qKX006d/8C4SolY0Jyl44Zm239MF0T8e4QYRiO6m9f/uCbtCykGJheI8H
         V72m2JZ2oqqUReAm9xN0ze6SAAVt5CjDnRdRCc5IBc5s4oVbTGNVwpT1h8PEY2/R1HOW
         /VVnCaBBCUK9sY2Wi0VEVwtUluMLFOr/wCx6cN92vs7GVl0C9JiMFySClDi8HFZG/bjf
         R2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724274260; x=1724879060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bca90P9ChDkgtck0w2Stz/QCYYqZlcBKDKfLWKWDSCU=;
        b=kdqgOfPhwhUPDDyQG/aR916V7KegAM6D/NnucF93JNW7rfBrKPscPrEIVT9ylbb07i
         haLLoOhMaSrcbEaRBB1fommaVdJiw+iiVrDry0la5+vYNFLGGvLJxSk6Q9CGgZOFMBEe
         WxpEjGrh3ObHK9J3hv/g1GwdrPGZ1vg6SxcTAwb/oV4MWhEPuHr6OL/zJ882/TR4SYvv
         uoKuFrhmcukyolTjpYd7kavJnh7yVWsht06WudMN3BiUTYPPptOqnQZBo6Uatccbc17P
         B5QBBwY+PKBfy8WdXBSNKI9CoSGI1rDzJrFjr2QCxZ84QSbiVYlRQqOVdgX6uiFj7ljY
         wYJA==
X-Forwarded-Encrypted: i=1; AJvYcCWvtJ0mxefAUQfXEhxGqZ32FNoRCJb+oJz+eEdBE2XBqj+WxdHpz0eU2q1XdZ3GLkcpsq/w+Y6A8PpBzHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvSPjgZtcSH0fO0ZWuB7bHAauitHksj8RHu+VD0c9Z96uXQ6PT
	lumhT00lQi8eZs6b29IBBdKgmbb9OMS8fzrGaKyT9HkXKHtYQ1ouov+JOoejQ8U=
X-Google-Smtp-Source: AGHT+IE9oj4hFtvRpFwqlNQh62iYP5rFySRwCQln/eAoZs0xPHX/uhuC97gaMUHeBpLyW4gq8rnotQ==
X-Received: by 2002:a17:907:7da0:b0:a7a:a46e:dc3c with SMTP id a640c23a62f3a-a866f2a00a5mr237191266b.15.1724274260340;
        Wed, 21 Aug 2024 14:04:20 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f220d36sm11170666b.20.2024.08.21.14.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 14:04:20 -0700 (PDT)
Date: Thu, 22 Aug 2024 00:04:16 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Vinicius Peixoto <vpeixoto@lkcamp.dev>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: Re: [PATCH] staging: rtl8192e: insert blank line after function
 declaration
Message-ID: <3953e259-cc8a-4076-a5d4-7e5107eda212@stanley.mountain>
References: <20240821204714.5839-1-vpeixoto@lkcamp.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821204714.5839-1-vpeixoto@lkcamp.dev>

On Wed, Aug 21, 2024 at 05:46:45PM -0300, Vinicius Peixoto wrote:
> This adds a blank line after the declaration of rtl92e_config_bb, in
> order to fix the following checkpatch warning:
> 
> CHECK: Please use a blank line after function/struct/union/enum
> declarations
> 
> Signed-off-by: Vinicius Peixoto <vpeixoto@lkcamp.dev>

Thanks.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter



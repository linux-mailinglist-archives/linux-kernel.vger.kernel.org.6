Return-Path: <linux-kernel+bounces-303371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5587C960B48
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 129AB28434B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B741BCA04;
	Tue, 27 Aug 2024 13:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iV9hwg40"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106E51A0718
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 13:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724763996; cv=none; b=Bc3uuVeMGStFXMl0bgxLFKla33r2q1WrN8IMZMr0+mp2lCc8DaQClp0Ojby9e4kI7P7W8qa9GFqLZNmwVdw0psKOiHtqIBN7fTi7QK6SYRT6AAzadDDrk9sGLiiwxykD7egHG8Q2Vhv04woxARvjWr9hJv/wHfTXw7Xft9nsqf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724763996; c=relaxed/simple;
	bh=I7QpzNgTozn0ypQN6lXdDMUyE5Ztc8z6lkFo/pacgsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CeDz8ca6mlECEdNSDk+uQ6ukVoZ7T/M+QlvIUxNYaRH+WB72wIY9CVxRzDIsHRUEgapEdBE7rzjCG+fXEZqUk5SEQrDO+7Rbto6Jokq8H2cZsW/JjKIDl3ng8whUL4SwXYuwmaSE6GsiTjwE4eUfuwQYy4CjCsU2hGF///3KMrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iV9hwg40; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8677ae5a35so520943766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 06:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724763993; x=1725368793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8nfq6eg/qBHA2qLWGmU88ECXRm0YOI1tfynwWiVtLqw=;
        b=iV9hwg4016z3VmMGgKt4G7CrVMHTFBrebURS0vuCy/QQwALL1LLrMtT1cpADT1hmP9
         Av/Fm3+CC+aBoTemfga/N76A5Tp4yKYANgYNZk5QFQXxzgTe+tnkq7qalFy8wNzQzpgx
         FUcCTIc+v97j8tzrz93htWlM16CH63DcEk2NHGYLb6nCDUcO7dvFGJH7Nozrc6Gsm7be
         EEy6XY6s0hAF270rjmo0SlgLzXhMHmBZKRSgbhHSJn6016RYyvvuC+YSSaU8BpwGj7aU
         TVvU4a4eWWxUK/nIHAA2PyCmpKI1GlMK5k1I4maQddOaiHXC1MKucMPTloj+w7P54qs3
         jRXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724763993; x=1725368793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nfq6eg/qBHA2qLWGmU88ECXRm0YOI1tfynwWiVtLqw=;
        b=tv+Rse6gt4f5wIysCfix9iy1DRBA/ucHzVkplgsVLZzkEYkzIGx0L0Q9YzS2yaEyLC
         oY8bhLxwgpt2uresJQLlTsqya5ZqXBIECp/TLdgpZ5ZqwLm3eFMx8YiDsgYl+a9euFaD
         L8ZvM/0w0GiWLm5rzKsX9EK8kv7xcPx2ehaB+ZzWhkE9ZySPDPOw/IvxS08NAiT8hSH8
         TPCKTgswS8zYvUCBCsQ5Y2wL/3A9ussusmDlM0X4CxS6axlYru6rkBkbD9rSHlh6VDzq
         hU/GQccETW2WU8Efj+2wpcfz7PO8aRVlO2ZpWvBqHULSIjOOieHmq9BBJ27WvfxG26Vo
         TKAA==
X-Forwarded-Encrypted: i=1; AJvYcCWZovyYn16VCeAwMudpk6YoxsC755xYQ2gFtvprf7BCC4yuMr+OTD+MGi1kIsBAj3iv1ujIk7n9noyg+OE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCcdQxddznR12n/tBxjuVC+gW4o5eE7GcoaJgbsWCdAoWwpTid
	yJn4TCkagWejppP4aiqFodlzPDpU3IyB6ckuXDruI4sdvxnhRG1G1EO90TdAtok=
X-Google-Smtp-Source: AGHT+IExA0IXeN0DpI3sjIu5CKqv5XLwnffzuIUhud55a0AvlWAI0prPHTf6ueNt50V82PQLu1aLVQ==
X-Received: by 2002:a17:907:72c7:b0:a86:9053:d93a with SMTP id a640c23a62f3a-a86e3a36950mr198914366b.31.1724763993148;
        Tue, 27 Aug 2024 06:06:33 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e582d43dsm107637966b.115.2024.08.27.06.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 06:06:32 -0700 (PDT)
Date: Tue, 27 Aug 2024 16:06:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Riyan Dhiman <riyandhiman14@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH v3] staging: vme_user: added bound check to geoid
Message-ID: <5cca227c-045d-4053-aed8-4ee020291e9a@stanley.mountain>
References: <20240827125604.42771-2-riyandhiman14@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827125604.42771-2-riyandhiman14@gmail.com>

On Tue, Aug 27, 2024 at 06:26:05PM +0530, Riyan Dhiman wrote:
> The geoid is a module parameter that allows users to hardcode the slot number.
> A bound check for geoid was added in the probe function because only values
> between 0 and less than VME_MAX_SLOT are valid.
> 
> Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
> ---
> v3: Fix commit message and remove redundant comment.
> v2: Removed unnecessary paranthesis and changed pr_err to dev_err.
> v1: Added bound check to geoid
> 

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter



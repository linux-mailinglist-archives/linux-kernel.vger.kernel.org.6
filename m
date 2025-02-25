Return-Path: <linux-kernel+bounces-530805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C80ECA438B9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C8CA7AC70D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8AC2627FC;
	Tue, 25 Feb 2025 09:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RiLOyJ66"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8138D261599
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474004; cv=none; b=ZV+1l7SwrurY7CK+0I51HQvTkPothq8UcVQoFSsbxEqdsksvqNZyVe9zPnNUrIOZOoWkEDCPJk4i/MI/35llcW/BSZzIeNrK4jTppHSFMRENjzUXC/ruphb1DDlHGLtx+9xx5J6CLTGWxEm/duLN1hpuG6F8lKFn0DzssLrUCJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474004; c=relaxed/simple;
	bh=boTfjNidvkL9xSdsP+7mdkh2MyGP2uPcA28blGXnIoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6XA/lVp/DC6yVPKPGfHj7zc1VSiLtUZByS5OCgPeHrKEGuFcCZ1KpKUcd2NhWP8HdMKqCh/T8VHqzZkGprcpeQneAybQz+pEdmH74ztW2ynG2If+LJrE1TEdpoVTC7pqJL86WCbPa65L8zYpTe5fAtPsyZe0ntifvCnxXnQ4AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RiLOyJ66; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-abbda4349e9so769524966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740474001; x=1741078801; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3nWDpO2Hjvy5Jf1DN3BUQOgX67wDnAHnQxhRWc9ZcCE=;
        b=RiLOyJ66Tri/808WtN5rZT79CD2CjO0Vvx7MbhRdazJyksAxX4yQ22mCg7SLz9yQJb
         Np3ZCuQpUXuWL0ehfTVoOiefaBcXgcpOfb3xxrFB4oOtWjNtjlWIqwH7sW89KhZxJP/9
         Rju/L+6AUpZ7RxRWGM+ONmQNA+52YcPwalWpyw/gv+cde5PZbK6JD4dMOHRKm2fr3JM6
         5xQrTpKDKV2KbsREzzshfcFLmt2hh0fgdhaeLo4Wv03OgWM+3wFUoUZ1cgCwsawgLuNT
         0Y042xrW5alE2nFK50OQjUiHWM6MjGukIoTjt8Q/+nVbd15CWYMJ0p9yzMpKcEbxU1tI
         UYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740474001; x=1741078801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3nWDpO2Hjvy5Jf1DN3BUQOgX67wDnAHnQxhRWc9ZcCE=;
        b=gtoqIzX2G08EiOOBdOdrgpDncijPAZn372UDCQlFnGOz14pG0hXcE0R/xnFL/U20iW
         Fz80vf6Q6O1gBE/hdYnD5qalgb3M3bQw2bjbG/wvrTu8C2CtBfpqSfzXG8ZHp6lyoCbR
         oKn+RYJ9LUro86K1mqP4dhHcByWG38kjDQDdAxSKrWAITUAbt2ZLKavTdBHxS8ig+nuj
         jYdEJxSaJ8nYyYwDnAw/vYKfNCZyFMCi1ZA9joWN/YeCZsYSlFbBeDtkuezL/Ay/5gFW
         ewMPKmVDgaWlMwo+b58wJXWeXtFULoD7ckcboVNOb5h6PxO0z5kv8JumT81rmrSfLHRE
         8vvw==
X-Forwarded-Encrypted: i=1; AJvYcCXAkQYVDFVQsTqooxzjXVxW7zRlW7b+Ta67mxeLmEkBiuqlJwLAWNF1obScYsyNsYNf2W2Xgd9Lb3eRu2A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw14Vcot0tCIIqZaYVT9fS07Ila6pTwVKC2sMvKNLz5OsZOnLN
	DvwumP5GqessJEFAotwC1bYBm9waD1RieCsUyl1Sm19RZLrIxzBc2UKRNRszmxQ=
X-Gm-Gg: ASbGncsbHxgMlB9eYifUu+ZRZtbZGV85I/VcK0a/QeklW5uf5YZBb+9RAM28U4wR7qw
	p3/1nQj3RZ6xLTXuCGzzvebRquAJCc9sd//5HdRPKndeRgokyz9KcVYUoPQlZ9ob3kyRSRMPhwH
	EGS8dUYoCn6gbqVHgVuVjgcmZb3kEeaNtw0zrFLzRrNB3fj+V5mCUSoXZmPOU6hZHYocOZ78pis
	c2uFdN2DZv+8i1fhPPAN1VOC3DfRtexdyd6KjU+2u7keovVzKYv22afqPSHNGR38LHE5G4bc8zc
	mFrBirN/c7wIUwo6papKPHv6+utE/KQ=
X-Google-Smtp-Source: AGHT+IHamUcVmT0cGXoadH2vs+yJ3faYw3PpkiOoCJcL9UZbYnBclxMPxwyo75rCi5dXwBfvFaNHbw==
X-Received: by 2002:a17:906:7311:b0:ab7:cfe7:116f with SMTP id a640c23a62f3a-abc0de0de62mr1522518766b.46.1740474000688;
        Tue, 25 Feb 2025 01:00:00 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abed1d68de8sm105893666b.70.2025.02.25.00.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:00:00 -0800 (PST)
Date: Tue, 25 Feb 2025 11:59:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dave Penkler <dpenkler@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gpib: Add return value to request_control
Message-ID: <f7521c95-e69c-4618-b078-283c156ca594@stanley.mountain>
References: <20250222202301.3729-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222202301.3729-1-dpenkler@gmail.com>

On Sat, Feb 22, 2025 at 09:23:01PM +0100, Dave Penkler wrote:
> A number of drivers are unable to release control due to
> hardware or software limitations. As request_control was defined
> as void - no error could be signalled. Some drivers also did
> not implement request_control correctly by setting
> controller_in_charge instead of system_controller.
> 
> This patch changes the prototype of request_control to int
> and adds the appropriate checking and returns. In the case
> that a board cannot release control EPERM is returned. The
> faulty implementations have been corrected.
> 

This patch is hard to read because it does several things:
1) It changes the functions from returning void to int.
   This is the overwhelming noisiest part of the patch so
   it's hard to even see the other changes in amongst the
   noise.
2) Returns -EPERM if request_control is false.
3) Changes some stuff like SET_DIR_WRITE(priv); and
   ENABLE_IRQ(priv->irq_SRQ, IRQ_TYPE_EDGE_FALLING);  I can't tell if
   that's related or not.

You'll need to do it in two or three patches.  The first thing is to
just change the void to int.  That's a simple mechanical change.  The
only worry is if some functions are returning an error code on failure
and I don't know the answer to that.  (That would break git bisect so it
would be against the rules, even if it's fixed in patch 2 and 3).

The actual logic changes will hopefully be easier to understand when the
diff is smaller.

> -static void agilent_82350b_request_system_control(gpib_board_t *board, int request_control)
> +static int agilent_82350b_request_system_control(gpib_board_t *board, int request_control)
>  
>  {
>  	struct agilent_82350b_priv *a_priv = board->private_data;
> +	int retval;
>  
>  	if (request_control) {
>  		a_priv->card_mode_bits |= CM_SYSTEM_CONTROLLER_BIT;
> @@ -354,7 +355,9 @@ static void agilent_82350b_request_system_control(gpib_board_t *board, int reque
>  			writeb(0, a_priv->gpib_base + INTERNAL_CONFIG_REG);
>  	}
>  	writeb(a_priv->card_mode_bits, a_priv->gpib_base + CARD_MODE_REG);
> -	tms9914_request_system_control(board, &a_priv->tms9914_priv, request_control);
> +	retval = tms9914_request_system_control(board, &a_priv->tms9914_priv, request_control);
> +
> +	return retval;

Get rid of the retval variable.  This should be:

	return tms9914_request_system_control(board, &a_priv->tms9914_priv, request_control);

> diff --git a/drivers/staging/gpib/common/iblib.c b/drivers/staging/gpib/common/iblib.c
> index fd2874c2fff4..3d51a093fc8b 100644
> --- a/drivers/staging/gpib/common/iblib.c
> +++ b/drivers/staging/gpib/common/iblib.c
> @@ -418,12 +418,19 @@ int ibsic(gpib_board_t *board, unsigned int usec_duration)
>  	return 0;
>  }
>  
> -	/* FIXME make int */
> -void ibrsc(gpib_board_t *board, int request_control)
> +int ibrsc(gpib_board_t *board, int request_control)
>  {
> -	board->master = request_control != 0;
> +	int retval;
> +
>  	if (board->interface->request_system_control)
> -		board->interface->request_system_control(board, request_control);
> +		retval = board->interface->request_system_control(board, request_control);
> +	else
> +		retval = -EPERM;
> +
> +	if (!retval)
> +		board->master = request_control != 0;
> +
> +	return retval;
>  }
>  

It would be better to reverse some of these conditions are return earlier
where it's possible.  (Always do failure handling, not success handling).

int ibrsc(gpib_board_t *board, int request_control)
{
        int ret;

        if (!board->interface->request_system_control)
                return -EPERM;
        ret = board->interface->request_system_control(board, request_control);
        if (ret)
                return ret;

        board->master = !request_control;

        return 0;
}

regards,
dan carpenter


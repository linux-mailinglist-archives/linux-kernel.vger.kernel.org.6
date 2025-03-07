Return-Path: <linux-kernel+bounces-551581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DFAA56E30
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3871189A435
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A3523CF06;
	Fri,  7 Mar 2025 16:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="roeLOZQG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0490917583;
	Fri,  7 Mar 2025 16:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741365963; cv=none; b=O2RzxlqiG4hCx5/jTRpO/dq5axPkcUk1Oau+6Rb27JjwEDNSFLzRi3XUAT/nWWobhT/iFDKZzhA+WT4YseMrDYhhteXu/HIU/+E7brm/ovG1n1RmUQbG5DRlkkLJ4/jHdRZXLPaLLUVv+02dRic2HKo0OrKeubGxAJZAXmTyAPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741365963; c=relaxed/simple;
	bh=dxkCyg9/hgzqXxZ4pSS0zIMJT2hY5GRvI0K+a6FCMkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e84LMG4nDGkhGJClJh9uZK6DuMKXkjT608RvHY0nbFdHeRzhV01RUD1irfCBMT+zAB67DAKKor4beMXNVKdcRhBlkHUHqfu66K668yyLVxYNFKN7OIgDc0orlbKGwwla9LiFVuo/V5cB41kT12hebbuus9aJyzsRbw+BoLG04tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=roeLOZQG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D47C4CED1;
	Fri,  7 Mar 2025 16:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741365962;
	bh=dxkCyg9/hgzqXxZ4pSS0zIMJT2hY5GRvI0K+a6FCMkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=roeLOZQGSeZ329Fhb4v2Ke0hje6eWox1bXX2gXM8giovzLjJcsk/ijPkdIdWHM/SV
	 8lJyuWnhRwQQU3v/t71XgJpt0cGA9ZC46kDJ1sJi8Bf6tbwF/CGd1LC2byHZ0dziwu
	 D/yv2k7MKkKl1i4euDLWoTXOWXRsMw0/CcxupXZkG7mAYUTqOrDxlt5BlnOByRf6Js
	 gLea4imWQDPhGgF41QBRcP5GR8rGmrxHkNBrSvMPspg6ZEaw6iPbVwMpsOj50t6SxY
	 9nvDGOYKomuMtIuuZ7paNcPGkl4ucJAAFDhPXIFXFwG7gwfRSzxMWTT/Ne4uW8532m
	 ND03eg2zRjhVA==
Date: Fri, 7 Mar 2025 18:45:57 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm, tpm_tis: Workaround failed command reception on
 Infineon devices
Message-ID: <Z8sixTuKG5sxO-D1@kernel.org>
References: <Z8lkSKOqBgt78pU2@earth.li>
 <Z8ogT_gERUYstPbK@kernel.org>
 <Z8sgfMmsfn894yLj@earth.li>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8sgfMmsfn894yLj@earth.li>

On Fri, Mar 07, 2025 at 04:36:12PM +0000, Jonathan McDowell wrote:
> On Fri, Mar 07, 2025 at 12:23:11AM +0200, Jarkko Sakkinen wrote:
> > On Thu, Mar 06, 2025 at 09:00:56AM +0000, Jonathan McDowell wrote:
> > > From: Jonathan McDowell <noodles@meta.com>
> > > 
> > > Some Infineon devices have a issue where the status register will get
> > > stuck with a quick REQUEST_USE / COMMAND_READY sequence. This is not
> > > simply a matter of requiring a longer timeout; the work around is to
> > > retry the command submission. Add appropriate logic to do this in the
> > > send path.
> > > 
> > > This is fixed in later firmware revisions, but those are not always
> > > available, and cannot generally be easily updated from outside a
> > > firmware environment.
> > > 
> > > Testing has been performed with a simple repeated loop of doing a
> > > TPM2_CC_GET_CAPABILITY for TPM_CAP_PROP_MANUFACTURER using the Go code
> > > at:
> > > 
> > >  https://the.earth.li/~noodles/tpm-stuff/timeout-reproducer-simple.go
> > > 
> > > It can take several hours to reproduce, and millions of operations.
> > > 
> > > Signed-off-by: Jonathan McDowell <noodles@meta.com>
> > > ---
> > >  drivers/char/tpm/tpm_tis_core.c | 17 ++++++++++++++---
> > >  drivers/char/tpm/tpm_tis_core.h |  1 +
> > >  include/linux/tpm.h             |  1 +
> > >  3 files changed, 16 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> > > index 167d71747666..e4eae206a353 100644
> > > --- a/drivers/char/tpm/tpm_tis_core.c
> > > +++ b/drivers/char/tpm/tpm_tis_core.c
> > > @@ -464,7 +464,10 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
> > >  
> > >  		if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
> > >  					&priv->int_queue, false) < 0) {
> > > -			rc = -ETIME;
> > > +			if (test_bit(TPM_TIS_STATUS_WORKAROUND, &priv->flags))
> > > +				rc = -EAGAIN;
> > > +			else
> > > +				rc = -ETIME;
> > >  			goto out_err;
> > >  		}
> > >  		status = tpm_tis_status(chip);
> > > @@ -481,7 +484,10 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
> > >  
> > >  	if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
> > >  				&priv->int_queue, false) < 0) {
> > > -		rc = -ETIME;
> > > +		if (test_bit(TPM_TIS_STATUS_WORKAROUND, &priv->flags))
> > > +			rc = -EAGAIN;
> > > +		else
> > > +			rc = -ETIME;
> > 
> > I'd encapsulate this inside wait_for_tpm_stat().
> 
> I think that gets a bit more complicated; this is an errata in the send 
> command path, for a stuck VALID bit, and the fix is to restart the whole 
> command send (i.e. we need to kick the TPM with tpm_tis_ready() etc). 
> I'm not sure returning EAGAIN in wait_for_tpm_stat() then makes 
> tpm_tis_send_data() any simpler.

OK, it is a fair argument. Let's keep it as it is.

> 
> > >  		goto out_err;
> > >  	}
> > >  	status = tpm_tis_status(chip);
> > > @@ -546,9 +552,11 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
> > >  		if (rc >= 0)
> > >  			/* Data transfer done successfully */
> > >  			break;
> > > -		else if (rc != -EIO)
> > > +		else if (rc != EAGAIN && rc != -EIO)
> > >  			/* Data transfer failed, not recoverable */
> > >  			return rc;
> > > +
> > > +		usleep_range(priv->timeout_min, priv->timeout_max);
> > >  	}
> > >  
> > >  	/* go and do it */
> > > @@ -1144,6 +1152,9 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
> > >  		priv->timeout_max = TIS_TIMEOUT_MAX_ATML;
> > >  	}
> > >  
> > > +	if (priv->manufacturer_id == TPM_VID_IFX)
> > > +		set_bit(TPM_TIS_STATUS_WORKAROUND, &priv->flags);
> > > +
> > >  	if (is_bsw()) {
> > >  		priv->ilb_base_addr = ioremap(INTEL_LEGACY_BLK_BASE_ADDR,
> > >  					ILB_REMAP_SIZE);
> > > diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
> > > index 690ad8e9b731..ce97b58dc005 100644
> > > --- a/drivers/char/tpm/tpm_tis_core.h
> > > +++ b/drivers/char/tpm/tpm_tis_core.h
> > > @@ -89,6 +89,7 @@ enum tpm_tis_flags {
> > >  	TPM_TIS_INVALID_STATUS		= 1,
> > >  	TPM_TIS_DEFAULT_CANCELLATION	= 2,
> > >  	TPM_TIS_IRQ_TESTED		= 3,
> > > +	TPM_TIS_STATUS_WORKAROUND	= 4,
> > 
> > TPM_TIS_TIMEOUT_AGAIN or maybe *_REPEAT? The current name does
> > not tell anything.
> 
> Yeah, TPM_TIS_STATUS_VALID_RETRY is perhaps clearer; it's not a timeout, 
> and we're looking to do a retry based on STS_VALID.

WFM


> 
> > >  };
> > >  
> > >  struct tpm_tis_data {
> > > diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> > > index 20a40ade8030..6c3125300c00 100644
> > > --- a/include/linux/tpm.h
> > > +++ b/include/linux/tpm.h
> > > @@ -335,6 +335,7 @@ enum tpm2_cc_attrs {
> > >  #define TPM_VID_WINBOND  0x1050
> > >  #define TPM_VID_STM      0x104A
> > >  #define TPM_VID_ATML     0x1114
> > > +#define TPM_VID_IFX      0x15D1
> > >  
> > >  enum tpm_chip_flags {
> > >  	TPM_CHIP_FLAG_BOOTSTRAPPED		= BIT(0),
> 
> J.
> 
> -- 
> ... "What's the philosophical difference between a killfile and the
>     automoderation?" "A killfile throws away good posts.  Automoderation
>     throws away bad posts." -- Jonathan H N Chin to Calle Dybedahl

BR, Jarkko


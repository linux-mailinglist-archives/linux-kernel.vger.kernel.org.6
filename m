Return-Path: <linux-kernel+bounces-424259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3FE9DB22B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 05:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC4F51673E3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 04:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65751386BF;
	Thu, 28 Nov 2024 04:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7cHF1HI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E06A45025;
	Thu, 28 Nov 2024 04:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732768176; cv=none; b=bY82MMu18bwpqiMFAR6FaBw9GmfhmD+8WQBmqCD2w5nalkUxJmws2YJOIwM4gh+gtJK6dVrQFPQ/ZgdbahMCHWqQD4lUgJTnQ+LzNd4yV0EjhFqI/NXXzAixYMPHhcZHqXfkaiaWWmwxihf3enbJhCd1RLQBKqL3bn+d+fuUWoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732768176; c=relaxed/simple;
	bh=ZReHJ+Ws4lewYIGJ0xabxD2HSvCS9j48AAi0eHrSfDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IuqaAE1qE4tYqa31Yz5VXcbisc2jkBqYrsJOnvXcEWVgA+qGkqUJEM+qyyik4aLZ3glHoLGAhscGbTUv0gSTR9PQ2nkB10PFs3pMmOc3ReRT/F7Bze4D/zp+UAbn+QYcVg4Rml+c/3+dRLu+cH5rvAmZTbmcxtU5nYgY6k+vcUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7cHF1HI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B450DC4CECE;
	Thu, 28 Nov 2024 04:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732768175;
	bh=ZReHJ+Ws4lewYIGJ0xabxD2HSvCS9j48AAi0eHrSfDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N7cHF1HIZ2+umIwzkBnR4sA/+gWTJbyLC0/Wj+0YkfH+xKZQIwo7MY9J4Wdy+WOOD
	 vTc+YZ1mZkgdZLZl/rE2T/0AXOAn9yJ6I2B73drGixgVI4ZVkepNafdeo+Fx6Lp9Dn
	 ZDa2e4GgyRjNfPtu/XcamXqdFtO3iVDJFdMxnceLfWCw5NhSLqyT6aKYNMJzHySvek
	 Uw/Bo50v/nHvyrPw67v5fU9HFgiPGSmZRrBI3RxfOc17JFjZmiY1QK/A9Vc3Zkig2q
	 19YVJbBs3pDoVB3rOHLMaktXUUZm80uWhR/uF1728TKO4IhXUuXjpjeihJV3mi8KWJ
	 Vj2QNNTvTnrHw==
Date: Thu, 28 Nov 2024 04:29:32 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Dawid Niedzwiecki <dawidn@google.com>
Cc: Benson Leung <bleung@chromium.org>, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org, chromeos-krk-upstreaming@google.com
Subject: Re: [PATCH 1/2] platform/chrome: cros_ec: jump to RW before probing
Message-ID: <Z0fxrDTuCIeCDTiV@google.com>
References: <20241125184446.1040187-1-dawidn@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125184446.1040187-1-dawidn@google.com>

On Mon, Nov 25, 2024 at 06:44:45PM +0000, Dawid Niedzwiecki wrote:
> To avoid such problems, send the RWSIG continue command first, which
> skips waiting for the jump to RW. Send the command more times, to make
> sure EC is ready in RW before the start of the actual probing process. If
> a EC device doesn't support the RWSIG, it will respond with invalid
> command error code and probing will continue as usual.

I'm wondering should it only send RWSIG_ACTION_CONTINUE if EC_CMD_GET_VERSION
shows the FW is still in RO.

Curious about: who (in which use case) is responsible for sending
RWSIG_ACTION_ABORT if it wants the EC stays in RO?

> diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
[...]
> @@ -204,6 +204,11 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>  	mutex_init(&ec_dev->lock);
>  	lockdep_set_class(&ec_dev->lock, &ec_dev->lockdep_key);
>  
> +	/* Send RWSIG continue to jump to RW for devices using RWSIG. */
> +	err = cros_ec_rwsig_continue(ec_dev);
> +	if (err)
> +		dev_warn(dev, "Failed to continue RWSIG: %d\n", err);

Too verbose, use dev_info() instead.

> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
[...]
> +int cros_ec_rwsig_continue(struct cros_ec_device *ec_dev)
> +{
[...]
> +	for (int i = 0; i < RWSIG_CONTINUE_RETRIES; i++) {
> +		ret = cros_ec_send_command(ec_dev, msg);
> +
> +		if (ret < 0)
> +			error_count++;

Should it just return the error if the transmission fails?

> +		else if (msg->result == EC_RES_INVALID_COMMAND)
> +			/*
> +			 * If EC_RES_INVALID_COMMAND is retured, it means RWSIG
> +			 * is not supported or EC is already in RW, so there is
> +			 * nothing left to do.
> +			 */
> +			break;
> +		else if (msg->result != EC_RES_SUCCESS)
> +			/* Unexpected command error. */
> +			error_count++;

Same as `ret < 0`, should it just return if any unexpected errors?

> +		else
> +			/*
> +			 * The EC_CMD_RWSIG_ACTION succeed. Send the command
> +			 * more times, to make sure EC is in RW. A following
> +			 * command can timeout, because EC may need some time to
> +			 * initialize after jump to RW.
> +			 */
> +			error_count = 0;
> +
> +		if (error_count >= RWSIG_CONTINUE_MAX_ERRORS_IN_ROW)
> +			break;

It could return 0 if `error_count >= RWSIG_CONTINUE_MAX_ERRORS_IN_ROW`.

> +
> +		if (ret != -ETIMEDOUT)
> +			usleep_range(90000, 100000);
> +	}
> +
> +	kfree(msg);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(cros_ec_rwsig_continue);


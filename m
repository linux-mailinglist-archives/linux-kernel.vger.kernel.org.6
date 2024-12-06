Return-Path: <linux-kernel+bounces-434246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD589E63DE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 03:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 183E916A321
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 02:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA7714A60A;
	Fri,  6 Dec 2024 02:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="snn3Z+h2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6A813BAC6;
	Fri,  6 Dec 2024 02:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733450980; cv=none; b=R+KIYYlT3NwjvgAh/VpbTtDlnl2JlEIYwXJYihoy3Gvn0Ow6hgE/jDhqBEx68XlP8c7fYD4MpLIebuR4NXejVmECrAyIKpnuusXaaaFcEVqK9yqh8dV49FRWsqaLruqnbm92WAE4ABelDEKrW7YyKmtl+tIGSOBfHaYQdOfO18k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733450980; c=relaxed/simple;
	bh=2p+F8aGcQ4N408le4v+zeiI0NlrmhodhrzRX9gqjVr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6+SRu8s6XdoaYMNZme7+7uuQ2F55T98g0ikc1ZISxdMxAD9lUgmYD37mJqu7GDjh8mhUDTmKk5vvjNLJ5PSaFJjha+6kFm0sfI8LpGuZyoMVKjfmnILGT/LldTjccfl6ZhTAl+lTbw/Js0M4g/OQvc6TJmVKSo86kx+C41as4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=snn3Z+h2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B581C4CED1;
	Fri,  6 Dec 2024 02:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733450980;
	bh=2p+F8aGcQ4N408le4v+zeiI0NlrmhodhrzRX9gqjVr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=snn3Z+h2KMvyXImpaZRxPBQcmvTssEJ252ECXekm9jExd86996QRl0EbUMgn6thYR
	 gTk1Iw9MsfiyX3m4LUYhUjhgVlyBznJUWlwRUacGhYnkbQzZ3EI3RwQnKlWawjs2eV
	 epEwW7jQmjS9l8pwxdJtJDLXysTjo1IZE34eJftNCbi6V8D2CA+LLXPIChrtYV3ddQ
	 yRzgw7tdRbWGCgIULRGm3D1qn8h3v3GKP0bChNv7xfGwFoVs1qycwY+D/eeebWsVSX
	 QwyUwwE0oecE0m/3ZR3TlFsGiqh7E6MwPJdH3SPpjT24v65Ezo+I1fugQphKj123ET
	 Yq5PBUB3VGWiA==
Date: Fri, 6 Dec 2024 02:09:37 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Dawid Niedzwiecki <dawidn@google.com>
Cc: Benson Leung <bleung@chromium.org>, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org, chromeos-krk-upstreaming@google.com
Subject: Re: [PATCH v2 1/2] platform/chrome: cros_ec: jump to RW before
 probing
Message-ID: <Z1Jc4XC9z5lnYc4H@google.com>
References: <20241204104514.1541964-1-dawidn@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204104514.1541964-1-dawidn@google.com>

On Wed, Dec 04, 2024 at 10:45:13AM +0000, Dawid Niedzwiecki wrote:
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
[...]
> +int cros_ec_rwsig_continue(struct cros_ec_device *ec_dev)
> +{
[...]
> +	for (int i = 0; i < RWSIG_CONTINUE_RETRIES; i++) {
> +		ret = cros_ec_send_command(ec_dev, msg);
> +
> +		if (ret < 0) {
> +			error_count++;
> +		} else if (msg->result == EC_RES_INVALID_COMMAND) {
> +			/*
> +			 * If EC_RES_INVALID_COMMAND is retured, it means RWSIG
> +			 * is not supported or EC is already in RW, so there is
> +			 * nothing left to do.
> +			 */
> +			break;
> +		} else if (msg->result != EC_RES_SUCCESS) {
> +			/* Unexpected command error. */
> +			ret = cros_ec_map_error(msg->result);
> +			break;
> +		} else {
> +			/*
> +			 * The EC_CMD_RWSIG_ACTION succeed. Send the command
> +			 * more times, to make sure EC is in RW. A following
> +			 * command can timeout, because EC may need some time to
> +			 * initialize after jump to RW.
> +			 */
> +			error_count = 0;
> +		}
> +
> +		if (error_count >= RWSIG_CONTINUE_MAX_ERRORS_IN_ROW)
> +			break;

Only if `ret < 0` makes the condition true.  How about move the statement to
where `error_count` increases to make the intent more obvious?  I.e.:
    if (++error_count >= ...)


Return-Path: <linux-kernel+bounces-545013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9118AA4E7F6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BE1E19C6CF8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FD6292FA4;
	Tue,  4 Mar 2025 16:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="F20UWdmX"
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFB5292F8A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106659; cv=none; b=uGlbxcjwVI+ClwP7VUiTwROSa1+IZFzDLM/W82ZPZat6q10d+UMZiU3cpFwAPhMsNp8TTu4r5TfS7q4OBJXpQ4ZdMPfF7cETVBOj/TfVikqF5t5wlY/I+07IYEYJiiwBwoQNZ1KHz69pwAl63e/7FudbSm0IGccHhNIUB4Nkh28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106659; c=relaxed/simple;
	bh=guJBGzO1Eha8HKDWqHhA8DOn1M/7asKrN5QKZ8a9S/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vC9LjhZCJ2IjCmxT3dOdUX3GIpctRynCiKEnZXEObETH8Wl+0lE5BCjzYtNthr0HvXXs6OdiFyaUzZfdJNOY/zeNY24qwSE5Okp20UyczcWxnlqB20Q9YlccSkTlYhcveQB90AWmpdU8qiNCmWVS0KECLEReXM6RFQtYW0J6CFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=F20UWdmX; arc=none smtp.client-ip=212.77.101.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 37206 invoked from network); 4 Mar 2025 17:44:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1741106648; bh=C5H8MPAgBlTLIuqQ/Qmct0NSdBHozxJNJSqyQOSH4rE=;
          h=From:To:Cc:Subject;
          b=F20UWdmX0fzyD7DH6Tk+FbkxEP9fwGqZT5bVw1CJKXvp8+iQgHW1hX++YI1Qkr1S1
           us8+PuXP5jKFx8eFPq7sxZpxnCRDcrZqqoPlhazFPfr9EyTP3Pe8SZUQBZZrWyYj91
           VwwTejvKtAstp3XE8rH4Xe2NTPlJIR2M3M8X8dhExZ1STjkuD+EVD6pfVjsNxLOIS6
           dwdgJxfJxRrMMfGv1tQ8jEy7k9OpH+I2/Vb/+xNO7YD57AMYsOCSlCqIGYcXFBduTI
           Hce2kTUdQRAy/bMzBZVsrjCXThkWcxFbsCC1WBw3xTxnY3Q1XFsnCrfUUJNqKIyati
           5aHIERV2VPPjg==
Received: from 89-64-3-211.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.3.211])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <vulab@iscas.ac.cn>; 4 Mar 2025 17:44:07 +0100
Date: Tue, 4 Mar 2025 17:44:07 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: kvalo@kernel.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iwlegacy/4965: Cancel deferred work on device init
 failure
Message-ID: <20250304164407.GB67578@wp.pl>
References: <20250304031603.1989-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304031603.1989-1-vulab@iscas.ac.cn>
X-WP-MailID: d28b2ad49f0eaad49278b304ef4372e6
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [YUPU]                               

Hi

On Tue, Mar 04, 2025 at 11:16:03AM +0800, Wentao Liang wrote:
> In __il4965_up(), deferred work is not canceled in time when device
> initialization fails. This is harmless if the device has not started.
> However, in il4965_bg_restart(), if the device remains operational
> in any state other than S_FW_ERROR or S_EXIT_PENDING, a dereference
> operation needs to be performed when __il4965_up() fails.
>
> Add il4965_cancel_deferred_work() to the failure path of
> __il4965_up() to prevent potential errors. Even if the current code
> does not exhibit the described issues, adding this change can prevent
> future problems at minimal cost, improving the robustness of the code.

I think preventing potential future problems in this legacy driver
is not necessary since the driver will not be developed further.

> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/wireless/intel/iwlegacy/4965-mac.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
> index 05c4af41bdb9..3b21bd79f3a9 100644
> --- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
> +++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
> @@ -5591,6 +5591,8 @@ __il4965_up(struct il_priv *il)
>  	__il4965_down(il);
>  	clear_bit(S_EXIT_PENDING, &il->status);
>  
> +	il4965_cancel_deferred_work(il);

We can not cancel here as we have il->mutex locked, it will
deadlock in case of some pending work that holds the mutex.

>  	/* tried to restart and config the device for as long as our
>  	 * patience could withstand */
>  	IL_ERR("Unable to initialize device after %d attempts.\n", i);
> -- 
> 2.42.0.windows.2
> 


Return-Path: <linux-kernel+bounces-517721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D5BA384B8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67FC318928B7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 13:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB3B21C9FF;
	Mon, 17 Feb 2025 13:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V/Iz8AUY"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C708521C9FA
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 13:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739798974; cv=none; b=C3a/S1ZOOI0goW0BJ0DJnfUm/vZ2FBHYfFBv4VzzE6Pxg7TJ8M0vpCtTmbS86/LW0VLmjbjBLnrft5fSZWsBMngD+zV062SQfzRI93k03AZT73nmXPh/8h1Mj7DxakrJo82pcz1xGLSApVQlAaODZkYmz4z5JmsWtS6+68l1Xdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739798974; c=relaxed/simple;
	bh=DV51ze5a8SGI4xEy+jPcuI22Gq6NgvotxhOVjBVdx54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQ6SufIKZ6nuU5HKbpNRxwztCf+GJ+yoo/lXeYKKO7NqZU4et15J+j9K2UksfXvcTI8wTJF9GqYoV30JRjoDgPJMVKN4/FZbizmqBqC75pPM7W1n3oCON0m54EbLbpyR8nMwqFKFjBUv9/YlXtZ19Wu3bO+HZWZcEQ5DSw9rE44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V/Iz8AUY; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5dca468c5e4so7960755a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 05:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739798971; x=1740403771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i1kpOeB8ZqWfh1QFPFu7oEB7ZlfZU+voyOTWdaINdTE=;
        b=V/Iz8AUYeVMbBec06pYIJ40Y8CrSw3WXfulhOJZugycNcke/aCQaRK3KbKIS0LIpes
         aI7CSOcQs/4hkdjuGEZqmEO9NZAY08rLUlbrP3r1Csxvdqh2kGs+lrMaYO1ctEzoPZHe
         bSzi6yXUrMKcslO6JzVCHt5AAVFPZXuhCB8+LO6ckKsr4A2qtJgrVEeqwrIVLY3ytHOc
         V9FNPnLa0WPHLa9EFK92EB3Cm3Sz6YgfcRWW6OkYyPg7D0QHmPSPnre9DJKrdMRVcCGm
         1B8zT6vnY5bsvajOcN2jzC/RQfOrAwASV7r+G9KLq84GAP9rJENPm4OzAEsil4ETsJJM
         YaQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739798971; x=1740403771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1kpOeB8ZqWfh1QFPFu7oEB7ZlfZU+voyOTWdaINdTE=;
        b=BICeoaxvhna1rTbGpEw3cyV3QQeDlf2Tj8COoax9ZbitGeWd+RfCJZt+fEeP0pamAh
         ayPnfeBD73P7nQv03zrSmYRfJqrSW3LLxkdvFR4GzORQAst2rwanxS1hM0EZhzgUkuNV
         KVVcCJ83WkZxYJDe87Djx9l9ML1BG+ddYBVGXurNTAZ7qwm76/usSPqOzooa/iURLlMG
         HwscUcJp8t5gKiTgzoO+bOU1hRMpud1ondxRUB/8t1EkvX42kNZwJ+9/YGN1g+aayhZ5
         XQTB4uhd6C835KEeXv7PEyGw2X17qkhnD/kgpGSu7LS1KkWCFDog9SbI72Vy2NBWraHq
         4R5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUpXGGBWFH5LnNSrOOZsx4+eWkGtF0Atn8K/mRnoI2ExgJtsBeIuilptLmzM/n9rt8LPpvQTJ/l/+URrl4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4/6LX8Nsfgkefet/KeJvd6ced8z4jEeLV1EIPQuKzjuiy9Dir
	mnfSK/4+4j/s5JUeTt1AaTJ1cl+jpupgBIxTfF95r0MF7atdibdxOGMZlLzXIzo=
X-Gm-Gg: ASbGncskjwL5HdHkXA1Cpj9rAbvULBpF3SKIHUKPH6natKkVsI0kjyWoivM46FeGTXy
	wgnmvCjFt3/HV2EipkU6DyVWxweD32W4rU/mE557Alt0QiD5fl/Z4ArnsjIKxf4OeoKCxdBGA/e
	8f9BB6qzAA7w+rmKGqdWPfM0PjYuwmD7iWXp5tMDzwu9CMmXD0OMa1GlYJiIZDlALUqnMZoFmNZ
	K6pv/FyVMLnjuvvYgg/7wotSsYzZxOuallOijuyJksOWo+Dwo8eO38UDEZ9vm2WUakaqfnUoUUc
	XgNQIJKoer9DdBDkpZ3N
X-Google-Smtp-Source: AGHT+IH1m1F/eLaa2C6Uii8lE5ZVkES2AbK7ROTYKx22NnRBmgZ53IBnJpCCMDut9Wm8kO5DB2b9Zw==
X-Received: by 2002:a05:6402:3488:b0:5dc:a44f:6ec4 with SMTP id 4fb4d7f45d1cf-5e036092b01mr10193533a12.13.1739798971007;
        Mon, 17 Feb 2025 05:29:31 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5dece2880fasm7164512a12.78.2025.02.17.05.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 05:29:30 -0800 (PST)
Date: Mon, 17 Feb 2025 16:29:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ravi Kumar kairi <kumarkairiravi@gmail.com>
Cc: dpenkler@gmail.com, gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	kuba@kernel.org, rmk+kernel@armlinux.org.uk
Subject: Re: [PATCH 1/2] [PATCH V2 2/4] staging:gpib:agilent_82350b: Removed
 commented out code
Message-ID: <82854a6c-0d99-4e9e-90bb-d2136d1e8790@stanley.mountain>
References: <cover.1739783909.git.kumarkairiravi@gmail.com>
 <01a91fb16e4774be1d89f8e2819b453ea8936fcf.1739783909.git.kumarkairiravi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01a91fb16e4774be1d89f8e2819b453ea8936fcf.1739783909.git.kumarkairiravi@gmail.com>

On Mon, Feb 17, 2025 at 03:35:11PM +0530, Ravi Kumar kairi wrote:
> From: Ravi Kumar Kairi <kumarkairiravi@gmail.com>
> 
> Removed commented out debugging code to make code look cleaner as
> spcified by TODO
> 
> Signed-off-by: Ravi Kumar Kairi <kumarkairiravi@gmail.com>
> ---
>  drivers/staging/gpib/agilent_82350b/agilent_82350b.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
> index 5a74a22015..7936c7285d 100644
> --- a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
> +++ b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
> @@ -176,7 +176,6 @@ static int agilent_82350b_accel_write(gpib_board_t *board, uint8_t *buffer, size
>  
>  	event_status = read_and_clear_event_status(board);
>  
> -	//pr_info("ag_ac_wr: event status 0x%x tms state 0x%lx\n", event_status, tms_priv->state);
>  

The rules for splitting patches up are a bit subtle.  Here the rule is
that if you make a change, it can't introduce new style issues.  You've
introduced two blank lines in a row so you must delete one.



>  #ifdef EXPERIMENTAL
>  	pr_info("ag_ac_wr: wait for previous BO to complete if any\n");
> @@ -190,13 +189,11 @@ static int agilent_82350b_accel_write(gpib_board_t *board, uint8_t *buffer, size
>  		return retval;
>  #endif
>  
> -	//pr_info("ag_ac_wr: sending first byte\n");
>  	retval = agilent_82350b_write(board, buffer, 1, 0, &num_bytes);
>  	*bytes_written += num_bytes;
>  	if (retval < 0)
>  		return retval;
>  
> -	//pr_info("ag_ac_wr: %ld bytes eoi %d tms state 0x%lx\n",length, send_eoi, tms_priv->state);
>  

Same.

>  	write_byte(tms_priv, tms_priv->imr0_bits & ~HR_BOIE, IMR0);
>  	for (i = 1; i < fifotransferlength;) {
> @@ -210,8 +207,6 @@ static int agilent_82350b_accel_write(gpib_board_t *board, uint8_t *buffer, size
>  		}
>  		writeb(ENABLE_TI_TO_SRAM, a_priv->gpib_base + SRAM_ACCESS_CONTROL_REG);
>  
> -		//pr_info("ag_ac_wr: send block: %d bytes tms 0x%lx\n", block_size,
> -		// tms_priv->state);
>  

Same.

>  		if (agilent_82350b_fifo_is_halted(a_priv)) {
>  			writeb(RESTART_STREAM_BIT, a_priv->gpib_base + STREAM_STATUS_REG);
> @@ -226,7 +221,6 @@ static int agilent_82350b_accel_write(gpib_board_t *board, uint8_t *buffer, size
>  						  test_bit(TIMO_NUM, &board->status));
>  		writeb(0, a_priv->gpib_base + SRAM_ACCESS_CONTROL_REG);
>  		num_bytes = block_size - read_transfer_counter(a_priv);
> -		//pr_info("ag_ac_wr: sent  %ld bytes tms 0x%lx\n", num_bytes, tms_priv->state);
>  
>  		*bytes_written += num_bytes;
>  		retval = translate_wait_return_value(board, retval);
> @@ -238,8 +232,6 @@ static int agilent_82350b_accel_write(gpib_board_t *board, uint8_t *buffer, size
>  		return retval;
>  
>  	if (send_eoi) {
> -		//pr_info("ag_ac_wr: sending last byte with eoi byte no:   %d\n",
> -		// fifotransferlength+1);
>  

Here you should delete the blanke as well.  I don't know if checkpatch
will complain but you can't have a blank line after a { or before a }.

regards,
dan carpenter



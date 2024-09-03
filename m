Return-Path: <linux-kernel+bounces-312259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 997A7969428
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBFD61C2104D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 06:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DAC1D54E3;
	Tue,  3 Sep 2024 06:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="TJkkp3Er"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EB21CB527;
	Tue,  3 Sep 2024 06:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725346263; cv=none; b=hsObOVdccerY7hsUizCwUQCbulscy8Xdh7IaMVAdak0swjzXkq+Iql+oflVSgH6JgwXREN0yVHFaoXWPDduaRdA7HCL+pVx7CpBHyMaReHoTsjQRJVr9w0iG+UW6w5Crlx1qxfJSKkXGRWp9GHShMClBnHBbY0gBKuslJZrIzkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725346263; c=relaxed/simple;
	bh=WpumRZm1NHOjiTyV36mpAGsOJJyaAKwLkeRWuW8u4mE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TR99vX4rbMm/xGrXP6fsnGHbpulCpJh62zB2PkbSZ0s+cyxGe1/xKmsmsxucUgpjkpb5LJn5IdCzTPRV7LoWgF+7cCZpNRvqRKXZbhrvvBXPb1n9i2EQxRXk6MfpuBH/unHlQc/EMpC+6Vc9piVn3JKNyWipg/716iR2a69taWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=TJkkp3Er; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1725346259;
	bh=CQh0HwbwudB1Ww2VJkCueArmMI0AZXpCTMdiFdJKXpI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=TJkkp3ErSASQvhmMaTnHtityUB+krmJD4Y3zwvw6vlTumSrwmJStye9dB1DwAPiRO
	 xcdsxaYqL7NAnSy0J7S565BeSD17qUpIFYfb0o83u+kXV/FGFvDZ3VL1FD3sxCbuHm
	 Vs0hY/tI/8Iu0z92RQH64V156VoHgCkOOiK5Jpo4l+TvolJ26gL9yA0mL7KUOkFc26
	 oeUaQjbd0lsBh+7y1JmjFfFK3bovuuL4kZ2uRAeSBYOuGmnVJy/nv0VnSd2Hl7H3Lz
	 kEvjRiVx5UHmnqbu0Svdei7SvKBdhVf0HXjsV6G7u0746zt1QQ/3vnqmG80RI4N/Z/
	 oY6CKnKhr6exQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Wybql3cL7z4w2F;
	Tue,  3 Sep 2024 16:50:59 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Chen Ni <nichen@iscas.ac.cn>, gregkh@linuxfoundation.org,
 jirislaby@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Chen Ni <nichen@iscas.ac.cn>
Subject: Re: [PATCH] tty: hvc: convert comma to semicolon
In-Reply-To: <20240903023001.491055-1-nichen@iscas.ac.cn>
References: <20240903023001.491055-1-nichen@iscas.ac.cn>
Date: Tue, 03 Sep 2024 16:50:58 +1000
Message-ID: <87y1495iy5.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chen Ni <nichen@iscas.ac.cn> writes:
> Replace a comma between expression statements by a semicolon.
>
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/tty/hvc/hvsi_lib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

> diff --git a/drivers/tty/hvc/hvsi_lib.c b/drivers/tty/hvc/hvsi_lib.c
> index 22e1bc4d8a66..b35c44caf3d7 100644
> --- a/drivers/tty/hvc/hvsi_lib.c
> +++ b/drivers/tty/hvc/hvsi_lib.c
> @@ -303,7 +303,7 @@ int hvsilib_write_mctrl(struct hvsi_priv *pv, int dtr)
>  	pr_devel("HVSI@%x: %s DTR...\n", pv->termno,
>  		 dtr ? "Setting" : "Clearing");
>  
> -	ctrl.hdr.type = VS_CONTROL_PACKET_HEADER,
> +	ctrl.hdr.type = VS_CONTROL_PACKET_HEADER;
>  	ctrl.hdr.len = sizeof(struct hvsi_control);
>  	ctrl.verb = cpu_to_be16(VSV_SET_MODEM_CTL);
>  	ctrl.mask = cpu_to_be32(HVSI_TSDTR);
> -- 
> 2.25.1


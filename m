Return-Path: <linux-kernel+bounces-169348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8688BC76D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A830C281519
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 06:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6DD4CB36;
	Mon,  6 May 2024 06:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CaQsRKB2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786F347F4A;
	Mon,  6 May 2024 06:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714976242; cv=none; b=c336zpvl+AdzXj6jP67lqGnrS2NHqwFUsDBBJcWcXc6JRIscHpkxekL3iX3r6KQ1uxDlmzYW47k+28EowXJQIcI+3RPlPEj03VTLv3kgix/VFcQ2WTeXi/+Gl8Jp7F/vI48b76ewfjNoIgiBYTO9wk47SXms6Ooy7U4WRAXbzJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714976242; c=relaxed/simple;
	bh=Yhvm4KfTp3bYgHbZn5YAwCk1umadg5T6YbYv0qfGjg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmaGRzfkup+XL3SKuObmc0U7KLn8/SSEgkjVipD+GRFDq1h++ijh8jO4RuN4+jiorB1e8CYioDpdn/+bDCOgwWldIu4R+REnGXKOnFNAiG58xBRmenku/mDLSjm2JuGfMK/6QF1j/BA6oC0P8Ht8AdVo7RVkOuCtNL1c3CsD6ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CaQsRKB2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4AFDC116B1;
	Mon,  6 May 2024 06:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714976242;
	bh=Yhvm4KfTp3bYgHbZn5YAwCk1umadg5T6YbYv0qfGjg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CaQsRKB2v8lEOLTrLKY3RVj/U5SG/JFCDEy7/fzGm2nu+9X2Zyks6XIwO6UVIdLls
	 wvKoZpZ0TvDzc8MxsgFFrlwYB+Wf9QF01g8dRXhOMx0K5HtUoXbAkhm4GCfZ/BjMVC
	 4OsuO0i03glhENPRYqbZeTcAWH83IDOpoa71Wlm4=
Date: Mon, 6 May 2024 07:17:19 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, quic_ppratap@quicinc.com,
	quic_jackp@quicinc.com
Subject: Re: [PATCH] usb: dwc3: core: Fix unused variable warning in core
 driver
Message-ID: <2024050659-monogram-decade-f0db@gregkh>
References: <20240506051548.1768794-1-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506051548.1768794-1-quic_kriskura@quicinc.com>

On Mon, May 06, 2024 at 10:45:48AM +0530, Krishna Kurapati wrote:
> While fixing a merge conflict in linux-next, hw_mode variable
> was left unused. Remove the unused variable in hs_phy_setup call.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>

You forgot the reported-by: line :(

thanks,

greg k-h


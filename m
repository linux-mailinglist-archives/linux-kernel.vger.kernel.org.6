Return-Path: <linux-kernel+bounces-263495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7B893D6E2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDB9F1F249CB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF46517C7B2;
	Fri, 26 Jul 2024 16:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdP/gUOu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD5D7494;
	Fri, 26 Jul 2024 16:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722011216; cv=none; b=TGH6mx86WZfKNorAIXOUwLydEvtQqiGeAFHThTKwT4jNjnUNb2LA6QoWszkZWtd7XUz3laQ5cHGeybGgjmos8RH81jsih76J2/PZPUkHzSiX2oBr4/vT+bO8xV4L/ktfCzLo4PyJmuKXQ+mNo0FcpZiAE43CZJL0EOx7MPr+QnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722011216; c=relaxed/simple;
	bh=Z9MDpd0/sratOhzzvJVRKayG+mK5uW2w9XCAWyz+TLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWTj4mmrQfMbmdtNACF0KzGC03+70SyTeOKzPGqo4mrkOSS0XVku8s6E52dBRwUc2D+Kj+cZW3vRMeR/lRWQMEe92D265W4b6Hv0q1Fa/SVdtUfXTemoDvbUknJqXOaKoxzomgnqg3q7v50HN8QmHKVM7c8iIdAsU6T9vKb7SHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdP/gUOu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 280DBC32782;
	Fri, 26 Jul 2024 16:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722011215;
	bh=Z9MDpd0/sratOhzzvJVRKayG+mK5uW2w9XCAWyz+TLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UdP/gUOu60c16w5wKprzIb8apAUsojCNMT7ru9GT+86wMFSm7jpcDRBsZw6fth0S1
	 o0AqlIW74CSrDylV7iq+foy53jTb/DbM1Je6+Y9tP1hj5eixkpdvcs/FWWf/uyAH30
	 +1YAF5AW2ObcI7rB5xFZPkYJUQ8kCvVrLdDRsBPoH2oiILfQIhnuIVJe1K1TL4Rmas
	 /N7P3v+D7IoYZT2AokIa6ImySIb2YZVhuvq1dnaz9Yc9Zp/zbRpOLjGUTicu1ICUYo
	 yhhDnc2wAe7AHj86JJ8BYrtfaoaa9PmpcTYvlS+sAxYDhSXFVcRgq5KrY94xKnS2JM
	 cCzfxwNhq0gLg==
Date: Fri, 26 Jul 2024 11:26:53 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Marijn Suijten <marijn.suijten@somainline.org>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v2] usb: typec: fsa4480: Check if the chip is really there
Message-ID: <2joame35cxaypago3mh7k2tzfagaz7bf4f3kirqhadoqrfak5g@ccwrbosheamq>
References: <20240726-topic-fs4480_check-v2-1-901ca449db15@kernel.org>
 <2024072615-hassle-enclose-673f@gregkh>
 <30b6e9eb-a6f5-4238-93fe-4d8a19b31590@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30b6e9eb-a6f5-4238-93fe-4d8a19b31590@kernel.org>

On Fri, Jul 26, 2024 at 03:52:22PM GMT, Konrad Dybcio wrote:
> 
> 
> On 26.07.2024 3:12 PM, Greg Kroah-Hartman wrote:
> > On Fri, Jul 26, 2024 at 01:43:30PM +0200, Konrad Dybcio wrote:
> >> From: Konrad Dybcio <konrad.dybcio@linaro.org>
> >>
> >> Currently, the driver will happily register the switch/mux devices, and
> >> so long as the i2c master doesn't complain, the user would never know
> >> there's something wrong.
> >>
> >> Add a device id check (based on [1]) and return -ENODEV if the read
> >> fails or returns nonsense.
> >>
> >> Checking the value on a Qualcomm SM6115P-based Lenovo Tab P11 tablet,
> >> the ID mentioned in the datasheet does indeed show up:
> >>  fsa4480 1-0042: Found FSA4480 v1.1 (Vendor ID = 0)
> >>
> >> [1] https://www.onsemi.com/pdf/datasheet/fsa4480-d.pdf
> >>
> >> Fixes: 1dc246320c6b ("usb: typec: mux: Add On Semi fsa4480 driver")
> >> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >> Signed-off-by: Konrad Dybcio <konradybcio@kernel.org>
> > You can't sign off on a patch twice, that makes no sense, sorry.
> 
> I'm losing access to the @linaro.org email and want to preserve the
> authorship there (as this patch was developed during work hours).
> 
> Then, the author's email doesn't match the sender's email, so I'm
> expected to sign off with the sender's one.
> 

The author is Linaro and as such the first s-o-b is correct/required.

> Should I assume that the maintainer trusts me to be the same person?
> 

I think in many cases you can assume that, but I find it reasonable that
you certify the origin of the patch anew, even though you happen to be
the same physical person.

Regards,
Bjorn


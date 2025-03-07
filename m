Return-Path: <linux-kernel+bounces-551935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB47A5731B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 21:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6F387A8D72
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 20:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7FD257455;
	Fri,  7 Mar 2025 20:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rx3UG0nl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C722561BD;
	Fri,  7 Mar 2025 20:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741380719; cv=none; b=Aj5hce5YNIuLXeCLL5QHF5aKDHk7gMs1UFJLi3kJoCZee4nzIkpIK0Q6pv1j6MglzFn77F9iKKa70/7XvKHVxN+Kl4bOdO/+rAI4mQNVDurjbBaBwqoPASANxim5+CDJ8ja5HS/bG6cn9SoQ64j/tqrNFTHjKjVxbTaAhx+xl1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741380719; c=relaxed/simple;
	bh=GGNUHmMxcy6R0lwyYXAWHuq9IENeuZCWMCuYICMOCkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzvItq3NIjFH5Teb9Q5CNcBPy/hkgi4fh+LRbxD5KWJ6qYqiFltRvzI5W6ggrvqRYESvp0y5M1BQTxCpXdrfq4jcY19tHV3i2+HMBup7YVOMnXwDThJzAr79QTMNb5ko8KKCWucorIP7qJF2DmkhGRiWbMmVpUZ1lqK1PV/BofU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rx3UG0nl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5359CC4CED1;
	Fri,  7 Mar 2025 20:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741380718;
	bh=GGNUHmMxcy6R0lwyYXAWHuq9IENeuZCWMCuYICMOCkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rx3UG0nlOjx2wRLfI/VRDwIiaxqaXwSPwrIiXjzY/IMj28NcF+NdHw7yBo5QUatvc
	 ET5KAUPkdBK8ZQn5tDanolEjB8FkpVFAtTUFjgxDzhZFDBaqiyl1fK23EFDFDnkKsw
	 npSNfgAqT52sZ0YsemlTbGO9ZJCJrKwYx0hpDc/Ltqv6WnG7FER/qAmEZiNk+R+eTj
	 r9sbQ7tOLdj7WUXpvoKM6NEYOBYm7t+WslJp6McQ9ihfbpVoWfiMDBRxuuCv92NkET
	 BPJZc1fgiDRsxzswxSxXqTehRj8YYBh2avtj1SMcjMHJ+tPfYDxWXr2i3PpSQeOsP5
	 yJ71XFg7vh2Vw==
Date: Fri, 7 Mar 2025 14:51:56 -0600
From: Rob Herring <robh@kernel.org>
To: James Calligeros <jcalligeros99@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>, Dan Murphy <dmurphy@ti.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shi Fu <shifu0704@thundersoft.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
	Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	asahi@lists.linux.dev, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v3 17/20] ASoC: dt-bindings: tas2770: add flags for SDOUT
 pulldown and zero-fill
Message-ID: <20250307205156.GA583954-robh@kernel.org>
References: <20250227-apple-codec-changes-v3-0-cbb130030acf@gmail.com>
 <20250227-apple-codec-changes-v3-17-cbb130030acf@gmail.com>
 <20250304135050.GA2485358-robh@kernel.org>
 <CAHgNfTyVKFuT0fZ3Qj=MdcXs67KscwkSepAH95xkAAKWM1g8Xg@mail.gmail.com>
 <20250305132239.GA1415729-robh@kernel.org>
 <CAHgNfTxS1Q4PPsw520-J4Yn6xg+QZOYFkYhg5yv-uZFu5waN_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHgNfTxS1Q4PPsw520-J4Yn6xg+QZOYFkYhg5yv-uZFu5waN_g@mail.gmail.com>

On Fri, Mar 07, 2025 at 04:18:31PM +1000, James Calligeros wrote:
> On Wed, Mar 5, 2025 at 11:22 PM Rob Herring <robh@kernel.org> wrote:
> > This just feels like something common because any TDM interface may need
> > to control this. It's not really a property of the chip, but requirement
> > of the TDM interface.
> 
> What I'm imagining then is something like:
> 
> dai-link@0 {
>     cpu {
>         sound-dai = <&some_cpu>;
>     };
>     codec {
>         sound-dai = <&some_codec>;
>         dai-tdm-tx-zerofill;
>         dai-tdm-tx-pulldown; /* either or, having both makes no sense */

If they are mutually exclusive, it's best to design the properties that 
way. So something like:

dai-tdm-tx-idle = "zerofill";
dai-tdm-tx-idle = "pulldown";

>     };
> };
> 
> Codec drivers would then provide a function to set TDM TX behaviour if they
> support it, and export that as a dai op for use by machine drivers
> when they parse
> the dai link similar to dai-tdm-tx-slot and friends. Is that close to
> what you have
> in mind?

How would it work when you need a mask? "dai-tdm-slot-tx-mask" is 
enough?

Rob


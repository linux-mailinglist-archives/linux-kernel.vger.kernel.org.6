Return-Path: <linux-kernel+bounces-196991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1A38D64AC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C14EB21CB8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E0552F71;
	Fri, 31 May 2024 14:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="Un9aMCGo"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85EC41C69;
	Fri, 31 May 2024 14:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717166437; cv=none; b=ZwhoymqzKRtiEBZEYjVx6pszNZxdlRabNomdfxm1iai2FJof/jit9pAbXU6muOzu+UroZQRqd3r6kozEBqxL3yYhrFuZ0EI5DJRsVnsNROdJdCNevtJuV5Zgb172MzQLxZ6zihM+IGVSamRHXtWq03kiyi4EErzJqV4V0NZvioQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717166437; c=relaxed/simple;
	bh=cVO1zYAC2fFp+2M6n/50pvfOMB27efWTsVzRMx4hPZ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GzxpK4xd5VlqgAB6LdEwLGHgGOennrkuYJlsQRTmPJrWgNWfWSqbPTSOcN08vB5FUxzWyyVtj3BEdDWjt/Rsauo1S07v8SAotpYVyuAuLwQcjQ4+LkhrefZvafoWxScJ7+VGS/gNwwk4qbccazFVBsrEalkpID4nfQFqytI38zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=Un9aMCGo; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ORkr0FUSsLGvEF3bN9w6PBzH9IbyeKtnP6Z+733ED7Y=; b=Un9aMCGoq7Xlcj1SBNXiHqSjhm
	lI9PFEekR6ylPHyF4JRi5PhFxuD1bobE4LcOc0YeDsfRoANphJqUxriNwwFbxHRbqlSrR+RGV8Nt2
	A9ar0J6BiEZssX8lKSwHNwjMcxtZc0lAJj8jA8s0GgbVbQygbFDHEIisraoeC8wRYKKv1ERGgPREN
	eEzqAVLLYAcAX102DPvmFUTpp59MILbr6i6cXm/WRoCv8nmTTABDkl8+vgKKXvIa+ouJsKKMTjTbY
	fF78Mmmi2rHWzJ72rGa36D/+jY76JHA0VkNhHV12UvH/GWWylcBeffGQk2o95G0dH1fxWMpDkxQVX
	7AjRjxpg==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sD3Qk-0007EQ-TF; Fri, 31 May 2024 16:40:30 +0200
Received: from [87.49.42.81] (helo=localhost)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sD3Qk-000K1h-29;
	Fri, 31 May 2024 16:40:30 +0200
From: Esben Haabendal <esben@geanix.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Shawn Guo <shawnguo@kernel.org>,  Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>,  linux-arm-kernel@lists.infradead.org,  Rasmus
 Villemoes <linux@rasmusvillemoes.dk>,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: ls1021a: add QUICC Engine node
In-Reply-To: <5987259.31r3eYUQgx@steina-w> (Alexander Stein's message of "Fri,
	31 May 2024 15:09:05 +0200")
References: <20240530-arm-ls1021a-qe-dts-v1-1-2eda23bdf8c5@geanix.com>
	<3380831.44csPzL39Z@steina-w> <87frtynpfx.fsf@geanix.com>
	<5987259.31r3eYUQgx@steina-w>
Date: Fri, 31 May 2024 16:40:29 +0200
Message-ID: <87ttiem4de.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27292/Fri May 31 10:31:14 2024)

Alexander Stein <alexander.stein@ew.tq-group.com> writes:

> Hi Esben,
>
> Am Freitag, 31. Mai 2024, 14:20:02 CEST schrieb Esben Haabendal:
>> Alexander Stein <alexander.stein@ew.tq-group.com> writes:
>> >> +			brg-frequency = <150000000>;
>> >> +			bus-frequency = <300000000>;
>> >
>> > Mh, aren't these values depending on your actual RCW configuration?
>> 
>> Yes, you are right. The QE bus-frequency comes from platform_clk which
>> is controlled by various bits in RCW and sys_ref_clk.
>> 
>> So I guess it should be possible to derive bus-frequency from sysclk
>> clock-frequency attribute and RCW. But fsl,qe bus-frequency is a
>> required property...
>> 
>> Max bus-frequency for LS1021A is 300 MHz. But it should be possible to
>> set it lower, although I suspect that many/most/everyone is running it
>> at 300 MHz.
>
> Thanks for confirmation. I'll let DT maintainer decide how to deal with this.

For reference.

The existing DTS with fsl,qe have the following bus-frequency property values:

arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi:  bus-frequency = <200000000>
arch/powerpc/boot/dts/fsl/mpc8568si-post.dtsi:   bus-frequency = <396000000>
arch/powerpc/boot/dts/fsl/mpc8569si-post.dtsi:   bus-frequency = <0>
arch/powerpc/boot/dts/fsl/p1021si-post.dtsi:     missing!
arch/powerpc/boot/dts/fsl/t1024si-post.dtsi:     bus-frequency = <0>
arch/powerpc/boot/dts/fsl/t1040si-post.dtsi:     missing!
arch/powerpc/boot/dts/kmeter1.dts:               bus-frequency = <0>
arch/powerpc/boot/dts/mpc836x_rdk.dts:           bus-frequency = <0>
arch/powerpc/boot/dts/mpc832x_rdb.dts:           bus-frequency = <198000000>

The 3 non-zero values are most likely also not guaranteed by SoC design
to always be the right values. But I haven't checked.

>> >> +			fsl,qe-num-riscs = <1>;
>> >> +			fsl,qe-num-snums = <28>;
>> >
>> > Current bindings defines:
>> >> fsl,qe-snums: This property has to be specified as '/bits/ 8' value,
>> >>   defining the array of serial number (SNUM) values for the virtual
>> >>   threads.
>> >
>> > So '/bits/ 8' is missing.
>> 
>> Ok, so you want me to add an array for fs,qe-snums attribute?
>> None of the existing fsl,qe devices has a fsl,qe-snums.
>> And qe_snums_init() has a fallback, so I don't think it is correct to
>> specify fsl,qe-snums to be a required property in the bindings. It
>> should be listed as optional.
>
> fsl,qe-num-snums is a deprecated property, so IMHO the replacement
> fsl,qe-snums should be used instead for new device tree entries.
> qe_snums_init() supporting 'fsl,qe-num-snums' is just to support
> "legacy bindings" as stated in the comment.

Figuring out the correct array values for fsl,qe-snums for ls1021a is
not so easy. It is not so clear from the reference manual, what it
should be. And the default array used for fsl,qe-num-snums = <28> does
not look right in any way, but seems to work.

It would not feel right to just copy those values and put into DTS, as
it would imply that the values are truly a correct description for the
LS1021A hardware.

>> 
>> >> +			};
>> >> +
>> >> +			muram@10000 {
>> >> +				#address-cells = <1>;
>> >> +				#size-cells = <1>;
>> >> +				compatible = "fsl,qe-muram", "fsl,cpm-muram";
>> >> +				ranges = <0x0 0x10000 0x6000>;
>> >
>> > Node address but no 'reg' property? I have no idea if this is okay.
>> > Also compatible (and possibly reg) first.
>> 
>> It is done in the same way for all existing fsl,qe-muram devices. So if
>> it is not okay, a tree-wide fixup would be in place.
>
> I can't finally say if this is okay, but at least the compatible shall be
> listed first.

Done.

/Esben


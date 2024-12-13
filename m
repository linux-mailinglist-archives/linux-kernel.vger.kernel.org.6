Return-Path: <linux-kernel+bounces-444266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C9D9F03C9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 05:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBC89283DD4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 04:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2024917D354;
	Fri, 13 Dec 2024 04:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="HwfKNMnM"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BF315442D
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 04:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734063810; cv=none; b=Hbb2QxzkLNRe5A8eY4Eiq0pBB3teFwugy5XG3qtScuJdUAfmgn4YGZzhVjI6g51tQNGMgW9pbd71RTpFGzeUK4KhpKkjfmsGLJqY5q61auD4KvPNWY+fwFsU+4PzgdNDV71p97AESCwjqBBooInhirQNG/UZcyx8BtbsXVZFXRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734063810; c=relaxed/simple;
	bh=41Wa87e1yvbGfsU8DFkP/vhEvzNEa4miGRYqLGm8xTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVelc0bg4ikJwC+i8DAE7O+MX1iNZed06XnqbMRkWlCSI3SQ2SICgHXWkvfodN+HKD5E1KpqS9dgayeR4JsqeET65e1a3UGjxE4Yy7yDg0mix1heJOBLObkVjza8ZfaNEizPaf1w0ZKZVY5HcMrKzYt3PPcDTlghSwq9f0DJlkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=HwfKNMnM; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-728f337a921so1477714b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 20:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1734063808; x=1734668608; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NVpovzDFXwge3Q3+ToA6U1Heg/KQVI3DYGJ0qfmqewk=;
        b=HwfKNMnMhXuLGpnzrX1nBNdA+VTldFz9Pq551ZJVnapLWQkpHzhiQ5qDzQQru3l5qM
         fySnbgujnBlF/mmQv9Tg8U9B94OfmYlc+II4+hIPRdrvcI4Bg6BD57DEdA7A9PIzqRkq
         CXG1WqMVH76VFdRPg5ye8yGfiZma1ycDUHmngw2TlX6xRMkXWBwXTpfMHcRthgtlsaEq
         AZVQahN57jSS6Lgn/ADtvHWeIAjKiOFsgqoyn5U5sgwAq5eR2cPq/MPEQhP+EQsDvk5v
         w2m4eu3HibAwfBjyqywFgxHzjp7noytKF0jl+qwTX7qaRuWW8EuCwH/UgbK26fDVtJQu
         WFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734063808; x=1734668608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVpovzDFXwge3Q3+ToA6U1Heg/KQVI3DYGJ0qfmqewk=;
        b=pTLkE7MSGj+6jrezJcI0V2cok/Ugpby+nOPPpjB8OoxF199vg9ohF3pPb8K4CnJnnG
         CyO9r7zm8RgZWyQWND6okr9jLoUs0M1qx6EDMV27mKbJrmzIDI0VFOR4VnIrovhmevyr
         YZJe0LQV1Gr7HZwrIuDhl5+2NVAcRiJgnCTzlcSN9ta+YtXBOZl3JYNrxyruKUUnbs8t
         0lvxwM89rehM+w7Fr68TYZTBlnGsIhzumPRSW9VyS55gauUU6iF9WuQUo3oErSJStAR7
         8K4AeJTGnfqVfBoWMQGLWpR6TRz19vxoXUOU8bH2vlpyXr26U5kGzjN0SMLUsg9ZK4+W
         O0Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXsW30RnD4c7CROFMr2Jm5dMX4C2m1snqfIe2cNT5DDz+DKhdUk75uXUM215ENFK0DwmoRZ5nyV8XxyY1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBnPMC3WjlKVQhgg06RzmnTzezcWoMTFRf3gKadwvyeJjd5HYY
	imtJIK/k9LbHDOueah8z0xPF3HWM8Uco/WLbkidLZQjVHwHVavt2pFdwExmK9w0=
X-Gm-Gg: ASbGnctS18AD3Ml4pxWx8mixRXaWjnCiCxqEU7DdqBIESnyKk8+SHWEm9f5JCyvAkjo
	isb1PUvfmclhR/ZPJ6319dZPBD4M0gO56DmN4hMCWJYROP8fzd+MC07IaMgEJQotcUKXXXXBvOn
	xsFD+vEllji6L8njschNrtIeuHSKJ/KGRHnWooXMjUgeepKrzD516Mm+b2eAO0MJgs6We0fK8Tq
	sgpOBNSyRk2R/1bVBffIt33FFhxBr46BX68x3OljbH4xCKVsM4hqGA34QpE8JSNP0QhCF4jtEeF
	afAS
X-Google-Smtp-Source: AGHT+IE1gWRpEWOOFyENRCzyuHkw+v1u7Rpqnlivn3esqNQkA9AcnHNhDDeYbLWGFzJcgO2JHohwSg==
X-Received: by 2002:a05:6a20:6a11:b0:1e1:c748:13c1 with SMTP id adf61e73a8af0-1e1dfdb04dcmr1876388637.27.1734063808159;
        Thu, 12 Dec 2024 20:23:28 -0800 (PST)
Received: from x1 (75-164-218-15.ptld.qwest.net. [75.164.218.15])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd313f0ffbsm10396549a12.82.2024.12.12.20.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 20:23:27 -0800 (PST)
Date: Thu, 12 Dec 2024 20:23:26 -0800
From: Drew Fustini <dfustini@tenstorrent.com>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: drew@pdp7.com, guoren@kernel.org, wefu@redhat.com,
	jassisinghbrar@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, m.szyprowski@samsung.com,
	samuel.holland@sifive.com, emil.renner.berthing@canonical.com,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v6 3/3] riscv: dts: thead: Add mailbox node
Message-ID: <Z1u2vsoCmmcNm82V@x1>
References: <20241104100734.1276116-1-m.wilczynski@samsung.com>
 <CGME20241104100801eucas1p27cd0d7b9b5b4500604470664884c42fb@eucas1p2.samsung.com>
 <20241104100734.1276116-4-m.wilczynski@samsung.com>
 <Z1oO5ewIOMFco4KI@x1>
 <Z1uiWXWo9szbgfx9@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1uiWXWo9szbgfx9@x1>

On Thu, Dec 12, 2024 at 06:56:25PM -0800, Drew Fustini wrote:
> On Wed, Dec 11, 2024 at 02:15:01PM -0800, Drew Fustini wrote:
> > On Mon, Nov 04, 2024 at 11:07:34AM +0100, Michal Wilczynski wrote:
> > > Add mailbox device tree node. This work is based on the vendor kernel [1].
> > > 
> > > Link: https://github.com/revyos/thead-kernel.git [1]
> > > 
> > > Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> > > ---
> > >  arch/riscv/boot/dts/thead/th1520.dtsi | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > > 
> > > diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
> > > index 6992060e6a54..89de5634d3d3 100644
> > > --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> > > +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> > > @@ -520,6 +520,22 @@ timer7: timer@ffffc3303c {
> > >  			status = "disabled";
> > >  		};
> > >  
> > > +		mbox_910t: mailbox@ffffc38000 {
> > > +			compatible = "thead,th1520-mbox";
> > > +			reg = <0xff 0xffc38000 0x0 0x6000>,
> > > +			      <0xff 0xffc40000 0x0 0x6000>,
> > > +			      <0xff 0xffc4c000 0x0 0x2000>,
> > > +			      <0xff 0xffc54000 0x0 0x2000>;
> > > +			reg-names = "local", "remote-icu0", "remote-icu1", "remote-icu2";
> > > +			clocks = <&clk CLK_MBOX0>, <&clk CLK_MBOX1>, <&clk CLK_MBOX2>,
> > > +				 <&clk CLK_MBOX3>;
> > > +			clock-names = "clk-local", "clk-remote-icu0", "clk-remote-icu1",
> > > +				      "clk-remote-icu2";
> > > +			interrupt-parent = <&plic>;
> > > +			interrupts = <28 IRQ_TYPE_LEVEL_HIGH>;
> > > +			#mbox-cells = <1>;
> > > +		};
> > > +
> > >  		ao_gpio0: gpio@fffff41000 {
> > >  			compatible = "snps,dw-apb-gpio";
> > >  			reg = <0xff 0xfff41000 0x0 0x1000>;
> > > -- 
> > > 2.34.1
> > > 
> > 
> > Reviewed-by: Drew Fustini <dfustini@tenstorrent.com>
> > 
> > dt_binding_check and dtbs_check are clean when I apply this patch to
> > v6.13-rc1. There is trivial conflict due to the gpio node label having
> > changed. I'll resolve it when I apply the patch to thead-dt-for-next.
> 
> I've applied this patch to thead-dt-for-next [1].
> 
> Thanks,
> Drew
> 
> [1] https://github.com/pdp7/linux/commit/98064af36cbc0c216d0a2d11da5e3746a57ccce7

I forgot my SoB so it is now a new hash [1].

-Drew

[1] https://github.com/pdp7/linux/commit/c95c1362e5bcd90c45987828bbef02236d181ffd


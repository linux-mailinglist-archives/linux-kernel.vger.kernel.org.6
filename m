Return-Path: <linux-kernel+bounces-444205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 859219F02D1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 03:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 471F7168BD6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 02:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4356A130A54;
	Fri, 13 Dec 2024 02:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="ZeINtLiG"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C754D34545
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 02:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734058591; cv=none; b=aKLQ4J8Y96sN2RgfAj7WwN64UhUzlhKf4eAs8Qc7iAPn3bqY44yk8vQjUyTlo2JzlX38TSJbwDWo7oXRY2woH0wXyj0WFRDqTUd8OAshaJ+ZwsFYX3rkEo9ZdgB/UOqc1Fg7J9Jh/DA6vZlXWov3y1YOyFtS3WG/zS4ilOSkCIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734058591; c=relaxed/simple;
	bh=msoRIi6q5Znx8858jCOffc0xZv9/XrVwI2YD5q+19zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rG+fIGXZ47Z7lkxXaB3mLRQPzjgCnc0CaquSqZBqSslwolgNKSEfl4SDWcViUZ8HI344xNyM/2mhIj3om06Pe5cP6lpAWhbhwMCBqFE9nTGwZYCc0y+5ApPUiTsah1cDiWGGnaybkzrijR1whh6A3kUnc5Kt20csF+JyGQLFLEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=ZeINtLiG; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-728f337a921so1426123b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1734058588; x=1734663388; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JyBVz9J4Iy1oVqyEvOxvCgnZn06m2Dd6z78eSL9EpLM=;
        b=ZeINtLiGLETXt6eo6oPd6eCZL0+2c3XHq5gu6dWwL6vz96wJk4VvDepQZF2c2kLbRO
         +r37Y1nfEj+p8u501rT3tXZGUsvZBWRMN59rOt/TaSL2XPb5QGe5a5+9/KBRuWFfBnaQ
         IURl1Jt/WBOKl6CxCJXgXA3I7XAbMGCnVAwevn98VSQHXkQUUGrgnWjwQrTNbQBTTc09
         9u9zZeu6f/7Z8qGI/GbFllqvFHbfHjAQf6GgDcgjJukst7dx7mXBk/EL2Vlc6huMyPiz
         PYb6JFk+QDlSmqKvlmfOnIrpZXgkJkTVPcwRnNeczZt8AhkD2wcRdm6KJJLvblp3mEzz
         oaLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734058588; x=1734663388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JyBVz9J4Iy1oVqyEvOxvCgnZn06m2Dd6z78eSL9EpLM=;
        b=aKjd1Tptn/m706lH6Wq9s/JCp34NCr3hDjlUAwm1cj2BGahWIbvVdJ9czmJddq5gK7
         Qu4YklHrkXLQ5cnxT/Mbv6aThaWRUvYlPUEsyL1d2WFG0W4X7/CvtNRmpFwokDSSSRTM
         fiMf1obmBU86TOEOJeH6/s/bpgN1lJqN7Ig7Kyw3oH0Ox/q7Nc2n39+sdJZpfgUBGEex
         K+1dPKjIeqKmvd9G43Sp46JuAIKXPV9Ph3r0cyzeAr4E8JDk/x9WEnNBtKyqAZyfUuKg
         k6YXSkmv5iT9CXVK8QsJUxWXcolFkQsHJT/9Nhs/9Xs4LcD3CZRbaUpw68qAAAQqdxTG
         3H0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXks2xJy840flZ8etb4MaggSe3UAcvFe/lUgK7YL9mP8K8e2PVliWfyzp/txneIaZLNlFVIGH5v83VeAXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT7hjdBSJ3fEMvWEIw4X+nZYdpRlNF/XnKHqtNO1cFelr+Muvf
	4xiqAjT7C45EXZmwtpyXhE6k1dpiH8t/3Kc5RjZmdXrHbzVVXGPYq4NjLNn7Ho8=
X-Gm-Gg: ASbGncs2UXlVRnqs7oaywwkXWoBXIA3f9+wdlPawmP/aOvPj85knflG7079ZFbuNli4
	NtNGzWpwySDpUW8qLK/4ocSITp9wh98GeuTSlt22LQVfOOt6feLR1wXNCrBs1SbTBSPOAkJ2TYo
	Xhd8Y3Bkasc9Yut1F0hokjGBSQMsgKXldIYgWAM3Lz2AGK3zMxy5O6LWzFfWsr8+xwIZEUBB2Y7
	yrpXQBkoiuoJmdn/8sRRmNGF1fbPRpCteN3WDAQGWY6Nb3VjxEXkLlsuzojAdhGRCuZkXmfmPEK
	2/EQ
X-Google-Smtp-Source: AGHT+IE3GLEOuUBB1zehzAwY9Ah5/2jVDz+WIAO7JDxIdFk51hMlAke8a4l8rZumyuvII+YjSfeLwA==
X-Received: by 2002:a05:6a00:4505:b0:725:e444:2505 with SMTP id d2e1a72fcca58-7290c0eea53mr1353429b3a.4.1734058587964;
        Thu, 12 Dec 2024 18:56:27 -0800 (PST)
Received: from x1 (75-164-218-15.ptld.qwest.net. [75.164.218.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725ea44c362sm8693583b3a.102.2024.12.12.18.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 18:56:27 -0800 (PST)
Date: Thu, 12 Dec 2024 18:56:25 -0800
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
Message-ID: <Z1uiWXWo9szbgfx9@x1>
References: <20241104100734.1276116-1-m.wilczynski@samsung.com>
 <CGME20241104100801eucas1p27cd0d7b9b5b4500604470664884c42fb@eucas1p2.samsung.com>
 <20241104100734.1276116-4-m.wilczynski@samsung.com>
 <Z1oO5ewIOMFco4KI@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1oO5ewIOMFco4KI@x1>

On Wed, Dec 11, 2024 at 02:15:01PM -0800, Drew Fustini wrote:
> On Mon, Nov 04, 2024 at 11:07:34AM +0100, Michal Wilczynski wrote:
> > Add mailbox device tree node. This work is based on the vendor kernel [1].
> > 
> > Link: https://github.com/revyos/thead-kernel.git [1]
> > 
> > Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> > ---
> >  arch/riscv/boot/dts/thead/th1520.dtsi | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
> > index 6992060e6a54..89de5634d3d3 100644
> > --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> > +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> > @@ -520,6 +520,22 @@ timer7: timer@ffffc3303c {
> >  			status = "disabled";
> >  		};
> >  
> > +		mbox_910t: mailbox@ffffc38000 {
> > +			compatible = "thead,th1520-mbox";
> > +			reg = <0xff 0xffc38000 0x0 0x6000>,
> > +			      <0xff 0xffc40000 0x0 0x6000>,
> > +			      <0xff 0xffc4c000 0x0 0x2000>,
> > +			      <0xff 0xffc54000 0x0 0x2000>;
> > +			reg-names = "local", "remote-icu0", "remote-icu1", "remote-icu2";
> > +			clocks = <&clk CLK_MBOX0>, <&clk CLK_MBOX1>, <&clk CLK_MBOX2>,
> > +				 <&clk CLK_MBOX3>;
> > +			clock-names = "clk-local", "clk-remote-icu0", "clk-remote-icu1",
> > +				      "clk-remote-icu2";
> > +			interrupt-parent = <&plic>;
> > +			interrupts = <28 IRQ_TYPE_LEVEL_HIGH>;
> > +			#mbox-cells = <1>;
> > +		};
> > +
> >  		ao_gpio0: gpio@fffff41000 {
> >  			compatible = "snps,dw-apb-gpio";
> >  			reg = <0xff 0xfff41000 0x0 0x1000>;
> > -- 
> > 2.34.1
> > 
> 
> Reviewed-by: Drew Fustini <dfustini@tenstorrent.com>
> 
> dt_binding_check and dtbs_check are clean when I apply this patch to
> v6.13-rc1. There is trivial conflict due to the gpio node label having
> changed. I'll resolve it when I apply the patch to thead-dt-for-next.

I've applied this patch to thead-dt-for-next [1].

Thanks,
Drew

[1] https://github.com/pdp7/linux/commit/98064af36cbc0c216d0a2d11da5e3746a57ccce7


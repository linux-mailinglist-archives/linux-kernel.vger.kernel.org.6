Return-Path: <linux-kernel+bounces-528239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 916F4A41551
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 07:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07691167076
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 06:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B981DC19D;
	Mon, 24 Feb 2025 06:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qoUD2t7f"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8E61C878E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 06:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740378483; cv=none; b=AzWVquDbJHbz1lZAAG3ACMj9WRagfcCYEd2/3xV8BSKbebmuTP5/VQqBEXCEliEszofJhTewxjcjX/gtHFszN4XfSWP5sBSp3rrUisr0h92WHgWz3hJV23IPd1I90y7Nhov6gepgh1e8ajaptzbam07z1hxoEIBD1p55wQ6zVD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740378483; c=relaxed/simple;
	bh=JBxYgWAZ28Kv42kvm7igFIx+vD9+GBBjiVu1EhW0iBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5Ya72fzXpWAibJWd/VZa+SuxgOWaaNa5WwMpoqFxf8TSuLw9JcsFm8RLqWFhXCEEnnlho77GuOad6DzAGWeV7oCihUMmgGLqqSTxl/P18eb5fT1n26G6Qcp4B3mBut5PWLZea5fxX3MRyfIsWiVaCQfd752V6ZRCA4NpqHjbMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qoUD2t7f; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2210d92292eso119629825ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 22:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740378480; x=1740983280; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PETCcKuB37T/wvrGB8m2s5znMowGvGlKoqhimbx768Q=;
        b=qoUD2t7fYY9xKe3RPR9q6Kmpq7u0/QGHeQAMiMXrljVDBuY/dcYtkY1OcMPcOSl2+E
         3aqt0gZtZcjZfVEjGxkWILxFyT4brbEzDIftrgP6KoFdD/COnFSTKe+WyZgF6+OHyHz6
         XQEh+8X7ztmafaIvsFJTMzoiXi5B5cXRXWIPJFtcKcBzS7xlxcbi4kQkNvgc/+ibic3t
         Q59qpFmZAnR+zvKgLKnhMKi+jDdsis7tc15IE4fBVX5S340lbDcRdJ82O0Vnzz0mc0TS
         7dl1SBCcsBgeojwDoHxqIclFTpo3jQRkP2WWzZzH/MRpfdpg+O5iQ2LTju7KpCx5Y/GM
         jqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740378480; x=1740983280;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PETCcKuB37T/wvrGB8m2s5znMowGvGlKoqhimbx768Q=;
        b=RTXgIN7IY1HP3hmWAsTNfQueufHS7AQ/bDX1wxp7JcP4vHvcogxJ7co9aKThohStCI
         smpF/l61ffgrZ7fe2BdPz92qmz6oIT3rNjmI51ohXN/KGJ+cXMjROHwc5VaECKoqE+DZ
         i0W0rsu9dRc7g5lrQOhXytcu/erPB/Gb3ZoqL43MVUp7GPvrUR7Rr0c3P1l3pTOPp+Ez
         yN70j42+ZigVWQ/TfrskgxRhD7xJfSaTI+c/zYpzg18WJD34w4M7jOmxHOZiiIBPvAl0
         U1P4pWMSyXORABx4xGArpFFpTnjVX6yNNus26RTCJ3pSNg54T2aMEYXffpPux+yO69YZ
         fTAg==
X-Forwarded-Encrypted: i=1; AJvYcCVcYT2RD/77DAPKQOQO20D+gCfbYYxQ0vJm2iE3sQLgCiVb3weB+Y2s6eH58X2q5mrWavr/sYccqiFkVKc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9dgNMAVONy7O+x/uHPB1++fTP1TEAbf1vRvBlhqrmygQg2TiS
	aQdJZXzXw46Z60Kst6TrlWN6lUF5T64ZF5nHktzSophkkopDlUeSKnIA65lrpA==
X-Gm-Gg: ASbGncsJduB4+xXmJs+5iZrPtOUhEnGNapx8KEA3gpA7hCN4fz/k2ZeRc35seI3gqNI
	cCSKYAt4Lb3uq+AH2r4IDtdJzamZObNe7tSriKSPEW2V2cbonintznKLbd+GfnRh0SgYcXai0GT
	MhAaKUZRjNuxHkHZIyb73fbp3SPYn8LSTHGy3wUpt0l4gQa14jzs45B8IJ8yORplcyWACs6lN23
	X8BwPAbyyLRMPuqzcMvB2RrTMp0YyVsTF77zaN82kZrlHZqBZ8NqgLRScl3zCZVXO0ADrBVTXmM
	85m1NVExmej7CZ4KGrVe2l9zug9rky2drjVP
X-Google-Smtp-Source: AGHT+IH1vvCmbqlYXXcs0TtiIJdkasozODilOIXoG9XWVanlEyl8M/uGy74MbXPTQ47Drg6++WedGA==
X-Received: by 2002:a17:903:18e:b0:220:c178:b3e with SMTP id d9443c01a7336-2219ff50bf0mr205208335ad.16.1740378479832;
        Sun, 23 Feb 2025 22:27:59 -0800 (PST)
Received: from thinkpad ([36.255.17.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7326a52f865sm15679226b3a.80.2025.02.23.22.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 22:27:59 -0800 (PST)
Date: Mon, 24 Feb 2025 11:57:50 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>
Cc: Chen Wang <unicorn_wang@outlook.com>, Rob Herring <robh+dt@kernel.org>,
	Chen Wang <unicornxw@gmail.com>, kw@linux.com,
	u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu, arnd@arndb.de,
	bhelgaas@google.com, conor+dt@kernel.org, guoren@kernel.org,
	inochiama@outlook.com, krzk+dt@kernel.org, lee@kernel.org,
	lpieralisi@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
	pbrobinson@gmail.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-riscv@lists.infradead.org, chao.wei@sophgo.com,
	xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com
Subject: Re: [PATCH v3 1/5] dt-bindings: pci: Add Sophgo SG2042 PCIe host
Message-ID: <20250224062750.nqgugglenzp76z3d@thinkpad>
References: <PN0PR01MB5662DF3C3D71A274A2E5B9C2FEC72@PN0PR01MB5662.INDPRD01.PROD.OUTLOOK.COM>
 <20250221221330.GA367172@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250221221330.GA367172@bhelgaas>

On Fri, Feb 21, 2025 at 04:13:30PM -0600, Bjorn Helgaas wrote:
> [cc->to: Rob]
> 
> On Fri, Feb 21, 2025 at 11:29:20AM +0800, Chen Wang wrote:
> > On 2025/2/20 2:22, Bjorn Helgaas wrote:
> > > On Wed, Feb 12, 2025 at 01:54:11PM +0800, Chen Wang wrote:
> > > > On 2025/2/12 12:25, Bjorn Helgaas wrote:
> > > > [......]
> > > > > > pcie_rc1 and pcie_rc2 share registers in cdns_pcie1_ctrl. By using
> > > > > > different "sophgo,core-id" values, they can distinguish and access
> > > > > > the registers they need in cdns_pcie1_ctrl.
> > > > > Where does cdns_pcie1_ctrl fit in this example?  Does that enclose
> > > > > both pcie_rc1 and pcie_rc2?
> > > > cdns_pcie1_ctrl is defined as a syscon node,  which contains registers
> > > > shared by pcie_rc1 and pcie_rc2. In the binding yaml file, I drew a diagram
> > > > to describe the relationship between them, copy here for your quick
> > > > reference:
> > > > 
> > > > +                     +-- Core (Link0) <---> pcie_rc1  +-----------------+
> > > > +                     |                                |                 |
> > > > +      Cadence IP 2 --+                                | cdns_pcie1_ctrl |
> > > > +                     |                                |                 |
> > > > +                     +-- Core (Link1) <---> pcie_rc2  +-----------------+
> > > > 
> > > > The following is an example with cdns_pcie1_ctrl added. For simplicity, I
> > > > deleted pcie_rc0.
> > >
> > > Looks good.  It would be nice if there were some naming similarity or
> > > comment or other hint to connect sophgo,core-id with the syscon node.
> > > 
> > > > pcie_rc1: pcie@7062000000 {
> > > >      compatible = "sophgo,sg2042-pcie-host";
> > > >      ...... // host bride level properties
> > > >      linux,pci-domain = <1>;
> > > >      sophgo,core-id = <0>;
> > > >      sophgo,syscon-pcie-ctrl = <&cdns_pcie1_ctrl>;
> > > >      port {
> > > >          // port level properties
> > > >          vendor-id = <0x1f1c>;
> > > >          device-id = <0x2042>;
> > > >          num-lanes = <2>;
> > > >      };
> > > > };
> > > > 
> > > > pcie_rc2: pcie@7062800000 {
> > > >      compatible = "sophgo,sg2042-pcie-host";
> > > >      ...... // host bride level properties
> > > >      linux,pci-domain = <2>;
> > > >      sophgo,core-id = <1>;
> > > >      sophgo,syscon-pcie-ctrl = <&cdns_pcie1_ctrl>;
> > > >      port {
> > > >          // port level properties
> > > >          vendor-id = <0x1f1c>;
> > > >          device-id = <0x2042>;
> > > >          num-lanes = <2>;
> > > >      }
> > > > 
> > > > };
> > > > 
> > > > cdns_pcie1_ctrl: syscon@7063800000 {
> > > >      compatible = "sophgo,sg2042-pcie-ctrl", "syscon";
> > > >      reg = <0x70 0x63800000 0x0 0x800000>;
> > > > };
> > 
> > I find dtb check will report error due to "port" is not a evaulated property
> > for pcie host. Should we add a vendror specific property for this?
> > 
> > Or do you have any example for reference?
> 

'port' is not a valid node name. It should be 'pcie' and should have the unit
address corresponding to the bridge BDF. Please refer DT nodes of other
platforms:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/qcom/sm8450.dtsi#n2071

- Mani

-- 
மணிவண்ணன் சதாசிவம்


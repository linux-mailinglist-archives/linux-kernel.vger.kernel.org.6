Return-Path: <linux-kernel+bounces-421267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 227A19D88D5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C905B16B8E0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EA31B6CE0;
	Mon, 25 Nov 2024 15:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TAQJ2x1b"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE34A1B4F1F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 15:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732547252; cv=none; b=IUHYtMPG9wRaTDqbLRAicZ9x6aHi7BAWUn7oceg8H9nELYro6nDn5ZfT1BmYmHnuZuimw30M4zotOJYgnEH6n/tieBtJFXbD0f1cNKxwXFzLbJ5/146FqL0mlTNIr+myWjL3gXyS3h5un7Pqw1z49TOr1ju/GG2mr6k1NDqjOSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732547252; c=relaxed/simple;
	bh=Q4aBnJqFOt15Ux30my9yAGcWPJu0Cl3Tq+l8YJKlqtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6GsE/ze8/RwX1t19cvQtmtbIiNMMfGsQ6JGYpwS6cAwVPFQcW3kVYC8Zyb6K25boi6KGzdGJqpgUFEZIcP5gGnEbySRIpDImeHr/BVml2Rw98xiR7DQweTULWyX2H+x5hYrlgam5Rdtj/uhqf9JqFFTZGPErU5FSgknUnG3sdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TAQJ2x1b; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b65db9b69fso132069285a.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 07:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1732547249; x=1733152049; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=twGWU6mtjTufZth/+pvf0jPNX0dQZ+T26QxysrcZJis=;
        b=TAQJ2x1bUDlNyQvWYOltLsFkP4fKwVwL8WlR7J2U5zO+OXmQ5iD2iPT0IH6OByMedq
         qZZPodjgIlOJS5Znuk+EhW5EdowLyB3xXrEquFcDXQKxA47azLookg2/8pmYLLzMMIWg
         +jzCbi1ZX2Mb+LOgRvckvNsZi3R0G5S5qiw+ozAP5NHe4jT+VN+3e7TsRux3BhnzV5CW
         XcLhl9bAks3A5y1VUMncKSE6+++9dYtbJ+OiA38ZkKao+9TVFNuXn5WM9IfiqrWHnlAt
         A4rUk4nULrgjeu7/vDM+nP1e1vBG/LdS4DMynOFVZAkn3YciatYMroz5fK490g4YlaX+
         15sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732547249; x=1733152049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twGWU6mtjTufZth/+pvf0jPNX0dQZ+T26QxysrcZJis=;
        b=XrGclKTANSMd8XJaabCqhUwcPVAe1rQwsKE8Us/lmr0tAbelxxAbEi9ALGtkwFI8Wx
         uK3jumHLuHlyxiOcTaj0PqZupefMA/spD88Pbnfw4qKVtkCoHsImQziutGt8dmnjDxz6
         wV2mdwNg1yPe6E+8IKYWcBn5sibPkhAB6/6wgK9eK7AZBpilnGaw9EFmyHhuthmGYpDx
         qSCGW+M9GVy979JkgkHHMxuBnq7ooyDy+8hV4v/rdYraAGRtgtZeCfiY8DkfITXD10AL
         B9s8YZFjlKPpIDsyBc87w23GxH41r4kh3lyd8VbaLkzJhBgeaAs9GJX3Ie8OLQL60IPL
         M43g==
X-Forwarded-Encrypted: i=1; AJvYcCUw1dvxe2gIcZp1hZH3aH06KDCvYHTAHDWBPkd61P6XM/vs6IzSrAl9BGtkJ9EzOgeFnof0RJcbthpsPMY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3+oth5R9+cZdov77jfnZFGAgyezcRYs4hpYcROG4GY0khtI/j
	guIbISsPzsCIhH/1QtUyZExg6rRAiii3Ju8vJ1GK++31Q64bY2UaUfutkUWwaa4=
X-Gm-Gg: ASbGncvmUk0OpZiABnXqUqs2WkUO04zTzJhO6H6fZelZP0tzyHTGrCSudwXvdJng0W8
	3zObUkf00/C/mcCrLjIZNhshC+/W8m/Mek4cXXAXO1VQzl2wrdVRcxoQ2EwrlqmR92ky358PzUl
	1UlhegKm3nutIBP4BmZYUD2yazOB3xLQrPMlZD8GLEuJwrameQrWNRZXvhqX+k5zCs9fVtab0+c
	+FLCHan6xT8SR2dAR5/uy8HR0ldWBNrpbHfZ0zQw4DfuKMd8YxCjIQHVgVvc6yVroWaCV/1VcSo
	oxXeOvfUChBb5q+ULbFG18M=
X-Google-Smtp-Source: AGHT+IFwf0rZmHcROgKHTVBJNGS81A60fdkLkHL/TjOd3GPuY+6MrtSu7XfH3JVuUswHCoYHME7qRA==
X-Received: by 2002:a05:620a:29c9:b0:7b6:6bd7:7adb with SMTP id af79cd13be357-7b66bd77cd2mr503418185a.23.1732547249439;
        Mon, 25 Nov 2024 07:07:29 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b66c8d41d8sm99837985a.95.2024.11.25.07.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 07:07:28 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tFagR-00000004zCr-3o1V;
	Mon, 25 Nov 2024 11:07:27 -0400
Date: Mon, 25 Nov 2024 11:07:27 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: iommu@lists.linux.dev, kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, tjeznach@rivosinc.com,
	zong.li@sifive.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, anup@brainfault.org, atishp@atishpatra.org,
	tglx@linutronix.de, alex.williamson@redhat.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Subject: Re: [RFC PATCH 08/15] iommu/riscv: Add IRQ domain for interrupt
 remapping
Message-ID: <20241125150727.GD773835@ziepe.ca>
References: <20241114161845.502027-17-ajones@ventanamicro.com>
 <20241114161845.502027-25-ajones@ventanamicro.com>
 <20241118184336.GB559636@ziepe.ca>
 <20241119-62ff49fc1eedba051838dba2@orel>
 <20241119140047.GC559636@ziepe.ca>
 <DE13E1DF-7C68-461D-ADCD-8141B1ACEA5E@ventanamicro.com>
 <20241119153622.GD559636@ziepe.ca>
 <20241121-4e637c492d554280dec3b077@orel>
 <20241122153340.GC773835@ziepe.ca>
 <20241122-8c00551e2383787346c5249f@orel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122-8c00551e2383787346c5249f@orel>

On Fri, Nov 22, 2024 at 06:07:59PM +0100, Andrew Jones wrote:

> > What you are trying to do is not supported by the software stack right
> > now. You need to make much bigger, more intrusive changes, if you
> > really want to make interrupt remapping dynamic.
> >
> 
> Let the fun begin. I'll look into this more. It also looks like I need to
> collect some test cases to ensure I can support all use cases with
> whatever I propose next. Pointers for those would be welcome.

Sorry, I don't really have anything.. But iommufd allows changing the
translation at will and we expect this to happen in normal VMM
scenarios. So blocking, paging, nesting are all expected to be
dynamically selectable and non-disruptive to interrupts.

So, you can't decide if remapping is enabled or not for a device based
only on the domain attachment.

I think you'd need to create a way for VFIO to request dynamic
interrupt remapping be enabled for the device very, very early in it's
process and that would remain fixed while VFIO is using the device.

The dynamic state of interrupt remapping would constrain what iommu
attachment configurations are permitted.

Jason


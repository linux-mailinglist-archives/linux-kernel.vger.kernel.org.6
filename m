Return-Path: <linux-kernel+bounces-236271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B11C91DFB8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C02CDB22E02
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BFF15AAC2;
	Mon,  1 Jul 2024 12:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sIMAuXXi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198DA7F9
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 12:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719837920; cv=none; b=Qz9djhNSmSxNb5drZq2tNefa2s6Fq33BaD1qbUw9KItw/fTVMl6440jnCi8bYdole3MVkSCXFpqo8C5Q9yLC2RO/OeizQ12iVMABW3NrKdcN3aExCiuZW/Di80jdvIZL3Ulu1UULi8a5Bq7iAmfsABCkDV29eas9cCUk0KRyEyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719837920; c=relaxed/simple;
	bh=mcsm+deKAsfjotatoCY43zzx8qAarB1cncwtOYmoE5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hh9saphAY6Ho52L6gdvVKiO4dPpxws4uzHnSmiFCVlpXvKE3wD+8BqBZydBYFgrKhUPvxvZu7CskuuaOLb84ZPrUbxKloscSq14ii8CQFeM8tTAWBIk7PnTCPLmAJvd1KcS8ZnRqagoKltXpM9gXmsUxcOWE8KIgKwKslz8QsjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sIMAuXXi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C3DC32786;
	Mon,  1 Jul 2024 12:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719837919;
	bh=mcsm+deKAsfjotatoCY43zzx8qAarB1cncwtOYmoE5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sIMAuXXin+3XP14RmiXZse6QmoojSzhAhVNx977D7LRV1aUwuXXsPVKcPY0MklDDn
	 nMcFphel2Ljruvv26XvXHEPdUdWrTwd+Bm7FqznD3lX/KIpr6kPPfgq0cKjrhi7KA3
	 4YAhGd78lMNmMy8LG6CYnSmNSd7TlpPqgIm0/0PA=
Date: Mon, 1 Jul 2024 14:27:04 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jari Ruusu <jariruusu@protonmail.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Stable linux-5.10.x regression triggered by MDS mitigation
Message-ID: <2024070152-unpaired-trouble-2632@gregkh>
References: <IdYcxU6x6xuUqUg8cliJUnucfwfTO29TrKIlLGCCYbbIr1EQnP0ZAtTxdAM2hp5e5Gny_acIN3OFDS6v0sazocnZZ1UBaINEJ0HoDnbasSI=@protonmail.com>
 <20240624170921.mep2x6pg4aiui4wh@desk>
 <yVXwe8gvgmPADpRB6lXlicS2fcHoV5OHHxyuFbB_MEleRPD7-KhGe5VtORejtPe-KCkT8Uhcg5d7-IBw4Ojb4H7z5LQxoZylSmJ8KNL3A8o=@protonmail.com>
 <20240625180150.7awxiyvmztcuu4pw@desk>
 <eK0mvc1FJknv3ZTg6opsYgeqRGgQCTFIQ-gdp5k0KdB3EsY-dL7cKmKvsG93qcTKvPQhrjkbRTrI32YK-AqMXcqiKqLetkLeDnn_b5qs7AA=@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eK0mvc1FJknv3ZTg6opsYgeqRGgQCTFIQ-gdp5k0KdB3EsY-dL7cKmKvsG93qcTKvPQhrjkbRTrI32YK-AqMXcqiKqLetkLeDnn_b5qs7AA=@protonmail.com>

On Wed, Jun 26, 2024 at 01:02:35PM +0000, Jari Ruusu wrote:
> On Tuesday, June 25th, 2024 at 21:01, Pawan Gupta <pawan.kumar.gupta@linux.intel.com> wrote:
> > Thanks for pointing this out, CLEAR_CPU_BUFFERS should happen before POPFL.
> > Below patch moves it before POPFL and also adds a safer version that
> > switches to KERNEL_DS before executing VERW. This should ensure VERW works
> > in all cases:
> 
> Your patch looks OK to me. Thanks.
> Tested on linux-5.10.220 inside 32-bit VM.

Great!  Hopefully someone submits this to the stable tree so we can
accept it...


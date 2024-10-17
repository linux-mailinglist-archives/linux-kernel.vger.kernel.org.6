Return-Path: <linux-kernel+bounces-369709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C41889A2189
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 493B5B21F82
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F891DC1BD;
	Thu, 17 Oct 2024 11:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Cq6mrZyy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5E11DB956
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 11:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729166119; cv=none; b=UPrqOHhCZ0YEGxKmTlX51O1dwjFj7zzMh1aKaaHGlEQQ9rB+ocN9VFF8grpOrQc41FktfcEkHlIctR4lv/2iVcvkdPoteEgQoAS0HiICYrSZ3/b8cZEHivZbWHey/6/rQYTQ5JGlA2Z1RFkzC4oBWo6/kHR3fLXJqHdk0D9i0PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729166119; c=relaxed/simple;
	bh=LY8oojiCq3wsBNPRMCamRFH1cr4CC2OkVN2/+47QA28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmtV3A6ulgIZANT+2Afe2WvKxZ6+BH8p3aaTf3TwIh3UGpvdL9tkPYeNW5ISOU3eKoYBcLTbecvN6SRtlOzOhutbopfYOiGeCO45DMsv1p9V+3zfwQe566WTMuefW7JdrLnazqkBmYJKtx1QRPS9uFnHGNgk8HIPZUhXM4DHRnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Cq6mrZyy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01678C4CEC3;
	Thu, 17 Oct 2024 11:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729166117;
	bh=LY8oojiCq3wsBNPRMCamRFH1cr4CC2OkVN2/+47QA28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cq6mrZyynSsS/Xn5HtrGcKo22IwO7BA+gAfpYc7yhEQ30qxyiG3d8IngPlPEMz+wS
	 rveZ+YcpBSncwXRo7AZvXRKsuXwPL09JinmywdiwOfpiVUi+cu+0TE2KLfmtn5PymD
	 XJRuTWIFSBXW8JUxv3zF/ppuGuhv5p3SW5ZM1ndA=
Date: Thu, 17 Oct 2024 13:55:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vimal Agrawal <avimalin@gmail.com>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, quic_jjohnson@quicinc.com,
	dan.carpenter@linaro.org, vimal.agrawal@sophos.com
Subject: Re: [PATCH v1 2/2] misc:minor basic kunit tests
Message-ID: <2024101744-blank-gander-03ac@gregkh>
References: <CALkUMdS3wEuSi5SGqsRKt3nSb4mHue1bJTJm8=QL3OLYU2GWig@mail.gmail.com>
 <20241017114329.22351-1-vimal.agrawal@sophos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017114329.22351-1-vimal.agrawal@sophos.com>

On Thu, Oct 17, 2024 at 11:43:28AM +0000, Vimal Agrawal wrote:
> basic kunit tests for misc minor
> 
> Signed-off-by: Vimal Agrawal <vimal.agrawal@sophos.com>

Your "From:" line says:
	From: Vimal Agrawal <avimalin@gmail.com>

Which does not match your signed-off-by line :(



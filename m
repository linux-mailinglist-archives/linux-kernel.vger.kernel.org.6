Return-Path: <linux-kernel+bounces-215215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E802908FDA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 18:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACB481F23876
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE2F16F0D1;
	Fri, 14 Jun 2024 16:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVZBLqZC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D87A19D8A5;
	Fri, 14 Jun 2024 16:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718381794; cv=none; b=mxUTWvU0XOSq1wYor3u0yrxqkCIHotl9LmHJ2ZT7vmECmaKPJHeouk+npJpRh75im5cD9KcPJCspT0J/zyLpGRmKDrCU4W48rRqQgZzoDrwVj8siQ9w2rJPOsXduKpVZlVqq+h9nr3LxSbeQWVzaIwaMBB2coDUjPaknRERGyBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718381794; c=relaxed/simple;
	bh=/m7C93ViXaAcLQc3o+A+6QGlNBUZog2Ouu/otDLJpY0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Vq67zPB+IGilNG+rSLExbE47NV8FFmJSPPIRjWvcY/cdpJKnKPiEMq5J1j2Szo3u3o4YM/4dmwU7VsmRoDPqsJkbMvddUyh1GFgTqB8ukIrghOWtF8amYwnLEVkryQRAgcKHfa9THgBWfL/AJ0m63lbxFDiHmD8RTSO0QybWcoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVZBLqZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2DB7C2BD10;
	Fri, 14 Jun 2024 16:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718381793;
	bh=/m7C93ViXaAcLQc3o+A+6QGlNBUZog2Ouu/otDLJpY0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZVZBLqZClfkIHgS8AkvPIHqYBNvvyMf/gLvvcJ5x4o8UxaYEcqSrWfDYBIHB/bBya
	 Asq/5Eb8NC2ChNEAD+kLM8nik6v7vSqzOzwAGL9FP9GPOJ0szbUaZIOIGpVXE3v+4I
	 dl90wllAI3KXnSuJyPmBFmwod39i9ZkpVGbgudUZf349hC6qXq6qaD3rgKfGf54jl3
	 +vluvgUcTBIBcdGdtr0A6H+cLz5Df2uaqodaxQEIwb0daroDnJOSsPGDwsB+QcqAgK
	 6/gYCH8dUd0zJj3eUcTYX536exO0d40YvNL6BqRDSPn2XNGh9r6C9z1HFIIaINWrxB
	 SfDQ3jFml8hxw==
Date: Fri, 14 Jun 2024 11:16:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sam Ravnborg <sam@ravnborg.org>, dakr@redhat.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v9 00/13] Make PCI's devres API more consistent
Message-ID: <20240614161632.GA1116318@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <442e5119dc4d2630b34d8cf9228c84b9cfee1717.camel@redhat.com>

On Fri, Jun 14, 2024 at 01:38:41PM +0200, Philipp Stanner wrote:
> On Thu, 2024-06-13 at 16:57 -0500, Bjorn Helgaas wrote:

> > This is on pci/devres with some commit log rework and the following
> > diffs.  I think the bar short/int thing is the only actual code
> > change.  Happy to squash in any other updates or things I botched.
> 
> I looked through your tree and only found the following nit:
> 
> In commit "PCI: Remove struct pci_devres.enabled status bit" you
> changed the line
> 
> "The PCI devres implementation has a separate boolean to track whether
> a"
> 
> to:
> 
> "The pci_devres struct has a separate boolean to track whether a device
> is"
> 
> In past reviews that has been criticized and I was told to always call
> it "struct pci_devres", not the other way around. That's also how it's
> put in the following paragraph.

Amended to that, thanks.


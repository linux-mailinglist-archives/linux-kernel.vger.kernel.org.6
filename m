Return-Path: <linux-kernel+bounces-550750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B5CA5639F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74C651760FE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A94C1A2C0B;
	Fri,  7 Mar 2025 09:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/RIq1Eu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BF615382E
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 09:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741339306; cv=none; b=ND97C3wEFmoqWK/cml/GrG/2t0VUh8hT85g1ii6jXx50HbCpRYLYFtJmMZNtzwqObkYDdL59+rgwLwU/MFVIb/EW0g4q9ngSf0XXhA54uZI64SuNRzKTslCoRODqPmNHGvJ/vjP8iupOuRSTfI1wAkhH/Z60Yv5JuDCS3P3CdRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741339306; c=relaxed/simple;
	bh=k/khH1ryQXKSIvefrNe8eYtkSHApJZW2VJgcTdYfhw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mC5Cgm5UatCNwYIIJqYLL33Yaw7Juo+YlYc0XJsBwLe1Vc+/mG8uJIv8fKS8dNTjv3n6d4We9oW8t3w0WXAhmaRuxpJw8BBiRWQQs3Bmz8+f8aZ/MBjnkG5K3fbeXbdaPWQUAyxEDthpWzq2bPKWVN+MfpCdaF/u3KOtD1egVEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/RIq1Eu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C97CC4CED1;
	Fri,  7 Mar 2025 09:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741339305;
	bh=k/khH1ryQXKSIvefrNe8eYtkSHApJZW2VJgcTdYfhw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q/RIq1EuWapouQCW0+FS6XC48+tSCmoLsqixjIJfKUjFh0c437fXFpDJb+CKW4cJS
	 F8i28U31KrjtrWGjuFSE6gm8Zx/yU5YvmzZfMROx6LnM2HIJO/PxM5xULI5X5X1npL
	 hJyrw1wa9HWkRWSV4jDmt2RkUy2Tr0V9cE/1K1AKAZOJoIDXcE4IKa65I5vdxD+jNY
	 64pR0jkaYGJtZaKGPVnGLapoTNkaNGKuN6lDLbLXl/8VHM9FHK6GXTrWr9zTngy+Ch
	 R5tm+naC0Iz8WZGqt9wlhBpARYH+3TkWSP2hhgdSPkoqUWA94E6YiiS9JHeSIAdhaV
	 xhKMVf0/B2k2Q==
Date: Fri, 7 Mar 2025 11:21:40 +0200
From: Oded Gabbay <ogabbay@kernel.org>
To: "Avizrat, Yaron" <yaron.avizrat@intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
	Ofir Bitton <obitton@habana.ai>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
	"jgg@nvidia.com" <jgg@nvidia.com>, koby.elbaz@intel.com,
	konstantin.sinyuk@intel.com
Subject: Re: [PATCH 1/1] MAINTAINERS: Change habanalabs maintainer
Message-ID: <Z8q6pCmCnVCCvBJK@GABBAY.>
References: <20240729121718.540489-1-obitton@habana.ai>
 <20240729121718.540489-2-obitton@habana.ai>
 <dc139f06-3f5a-4216-93c2-1e8b3b9c27ba@intel.com>
 <87cyevy9k0.fsf@intel.com>
 <f543ec81-1092-4700-b695-c4126f122444@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f543ec81-1092-4700-b695-c4126f122444@intel.com>

On Thu, Mar 06, 2025 at 03:51:24PM +0200, Avizrat, Yaron wrote:
>
> On 05/03/2025 13:57, Jani Nikula wrote:
> > On Wed, 05 Mar 2025, "Avizrat, Yaron" <yaron.avizrat@intel.com> wrote:
> >> On 29/07/2024 15:17, Ofir Bitton wrote:
> >>> I will be leaving Intel soon, Yaron Avizrat will take the role
> >>> of habanalabs driver maintainer.
> >>>
> >>> Signed-off-by: Ofir Bitton <obitton@habana.ai>
> >>> ---
> >>>  MAINTAINERS | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/MAINTAINERS b/MAINTAINERS
> >>> index ed2d2dbcec81..a4b36590061e 100644
> >>> --- a/MAINTAINERS
> >>> +++ b/MAINTAINERS
> >>> @@ -9599,7 +9599,7 @@ S:	Maintained
> >>>  F:	block/partitions/efi.*
> >>>
> >>>  HABANALABS PCI DRIVER
> >>> -M:	Ofir Bitton <obitton@habana.ai>
> >>> +M:	Yaron Avizrat <yaron.avizrat@intel.com>
> >>>  L:	dri-devel@lists.freedesktop.org
> >>>  S:	Supported
> >>>  C:	irc://irc.oftc.net/dri-devel
> >> Acked-by: Yaron Avizrat <yaron.avizrat@intel.com>
> >>
> >> Apologies for the long silence — it’s been a challenging period with
> >> the Habanalabs-Intel merger, but we're back and ready to continue
> >> contributing.
> >>
> >> We'll be moving forward with our roadmap — upstreaming the latest
> >> HabanaLabs driver, including recent changes and full support for the
> >> entire GaudiX series.
> >>
> >> To support this effort, Koby Elbaz and Konstantin Sinyuk will join me
> >> as co-maintainers on a regular basis.
> > Should they be added as maintainers in the MAINTAINERS entry too?
> >
> > Are you going to pick this up and apply to the Habanalabs repo, and send
> > a pull request with it? Or how do you propose to proceed?
> >
> >
> > BR,
> > Jani.
> >
>
> Yes, in a later patch, they would be added as maintainers in the MAINTAINERS entry too.
> Regarding your second question, we should start with merging Ofir's initial patch.
> Any additional/upcoming changes will be initially merged into the official HabanaLabs repo as you mentioned above.
>
> Regards,
> Yaron
>
Acked-by: Oded Gabbay <ogabbay@kernel.org>



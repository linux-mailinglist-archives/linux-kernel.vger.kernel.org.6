Return-Path: <linux-kernel+bounces-395052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCC39BB7D7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39CBB1F225AC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C78B1B0F12;
	Mon,  4 Nov 2024 14:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TOyMxrmL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3110AD2F;
	Mon,  4 Nov 2024 14:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730730749; cv=none; b=AWPuBAwG5ex1oEKijLsJRgam2PW2vcrp8yXJm0GfGLxQ+seQUODqffGgZEE5wxpe25s8hvWkueJ0TlXpCE/dd0rz9EwTxGDAPLRpxY7v1nC8R1At+yIqrgoCeLV+rk+AqepYaaBcs9j1XGs/EbIw/awtwESno/DwEmhYlYqfT6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730730749; c=relaxed/simple;
	bh=nwR9aONzVYrPtaCPM/rCOoBU/juFbUwDxewR2+ECA4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmbcEbfS97ADmAA8oGX6prSzHq1V233cOFu0/0GiZaGwh8m12+3GjyjdOY2KxIlPKzXrPvMX6S7iCetqgkOnOoeFN7xxV1kW8gApuz8eRKQUV1ekyZWPEQWdDHAI8cO9b9Smc504KyDrRaftumVAzIUnU6mS0sy7lUr5HyCYPls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TOyMxrmL; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730730748; x=1762266748;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=nwR9aONzVYrPtaCPM/rCOoBU/juFbUwDxewR2+ECA4U=;
  b=TOyMxrmLkq8ruBr4S1hkOLfjljKS7pCTKFWujh+ylsWkQtdohTJ2nLr5
   D93oTKaMEGyJ5mPeNCrVWgmHTBxzlue/sqmB3gkfI7gw8G1UySalfmgwb
   vDPcF/5xdCwHB2WOjvFBb9w/oERgK5E6QXCxTRyj82YLqjLe2JIBbMNzi
   MpmDsRO9GSY1ySz2e42IlYCHiIKCEBwzqhCEvOvuAH3d66K2u2GBQTJea
   BcHsKyY0BlpEIBGuacvT89txWGsXut2e2IuiHOO7uHjYumXci4/YYWU/K
   rGDsWa0SNyq0suFWz4Vlc96IG3l8yuuaze6y2ERM8YjhUJ7Ckdm3OcwEn
   w==;
X-CSE-ConnectionGUID: 4VRZYnqfSgymHwCnazGktA==
X-CSE-MsgGUID: u1DEyacWRM+IUXBRmEZnDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="55829949"
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="55829949"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 06:32:27 -0800
X-CSE-ConnectionGUID: FSB9NkaeQmGj5FxJ0bo+7A==
X-CSE-MsgGUID: 6hQy1VRTT1+GCJSPUFSNQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="88434652"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa003.jf.intel.com with SMTP; 04 Nov 2024 06:32:22 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 04 Nov 2024 16:32:21 +0200
Date: Mon, 4 Nov 2024 16:32:21 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc: tzungbi@kernel.org, linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev, dmitry.baryshkov@linaro.org,
	jthies@google.com, akuchynski@google.com, pmalani@chromium.org,
	Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] usb: typec: Add driver for Thunderbolt 3
 Alternate Mode
Message-ID: <Zyja9b2Xt-BEc-mx@kuha.fi.intel.com>
References: <20241030212854.998318-1-abhishekpandit@chromium.org>
 <20241030142833.v2.1.I3080b036e8de0b9957c57c1c3059db7149c5e549@changeid>
 <ZyOQJmF-PcFHgmeq@kuha.fi.intel.com>
 <CANFp7mXhwMMwyqbKqxe=SgCRPUyXVhKnsJwf0xgJ2LefOvrtjg@mail.gmail.com>
 <ZyTUsOg7cd6xSDhn@kuha.fi.intel.com>
 <CANFp7mVC1RVLF=OPD-jiv5cQeYaA8uqNA0xB5os3iAKo2DFWoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANFp7mVC1RVLF=OPD-jiv5cQeYaA8uqNA0xB5os3iAKo2DFWoA@mail.gmail.com>

On Fri, Nov 01, 2024 at 11:48:07AM -0700, Abhishek Pandit-Subedi wrote:
> On Fri, Nov 1, 2024 at 6:16 AM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > On Thu, Oct 31, 2024 at 04:02:22PM -0700, Abhishek Pandit-Subedi wrote:
> > > On Thu, Oct 31, 2024 at 7:11 AM Heikki Krogerus
> > > <heikki.krogerus@linux.intel.com> wrote:
> > > >
> > > > Hi Abhishek,
> > > >
> > > > On Wed, Oct 30, 2024 at 02:28:32PM -0700, Abhishek Pandit-Subedi wrote:
> > > > > From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > > >
> > > > > Thunderbolt 3 Alternate Mode entry flow is described in
> > > > > USB Type-C Specification Release 2.0.
> > > > >
> > > > > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > > > Co-developed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > > > > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > > > > ---
> > > > >
> > > > > Changes:
> > > > > * Delay cable + plug checks so that the module doesn't fail to probe
> > > > >   if cable + plug information isn't available by the time the partner
> > > > >   altmode is registered.
> > > > > * Remove unncessary brace after if (IS_ERR(plug))
> > > > >
> > > > > The rest of this patch should be the same as Heikki's original RFC.
> > > > >
> > > > >
> > > > > Changes in v2:
> > > > > - Use <linux/usb/typec_tbt.h> and add missing TBT_CABLE_ROUNDED
> > > > > - Pass struct typec_thunderbolt_data to typec_altmode_notify
> > > > > - Rename TYPEC_TBT_MODE to USB_TYPEC_TBT_MODE
> > > > > - Use USB_TYPEC_TBT_SID and USB_TYPEC_TBT_MODE for device id
> > > > > - Change module license to GPL due to checkpatch warning
> > > > >
> > > > >  drivers/platform/chrome/cros_ec_typec.c  |   2 +-
> > > > >  drivers/usb/typec/altmodes/Kconfig       |   9 +
> > > > >  drivers/usb/typec/altmodes/Makefile      |   2 +
> > > > >  drivers/usb/typec/altmodes/thunderbolt.c | 308 +++++++++++++++++++++++
> > > > >  include/linux/usb/typec_tbt.h            |   3 +-
> > > > >  5 files changed, 322 insertions(+), 2 deletions(-)
> > > > >  create mode 100644 drivers/usb/typec/altmodes/thunderbolt.c
> > > > >
> > > > > diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> > > > > index c7781aea0b88..53d93baa36a8 100644
> > > > > --- a/drivers/platform/chrome/cros_ec_typec.c
> > > > > +++ b/drivers/platform/chrome/cros_ec_typec.c
> > > > > @@ -499,7 +499,7 @@ static int cros_typec_enable_tbt(struct cros_typec_data *typec,
> > > > >       }
> > > > >
> > > > >       port->state.data = &data;
> > > > > -     port->state.mode = TYPEC_TBT_MODE;
> > > > > +     port->state.mode = USB_TYPEC_TBT_MODE;
> > > > >
> > > > >       return typec_mux_set(port->mux, &port->state);
> > > > >  }
> > > >
> > > > The definition should be changed in a separate patch.
> > >
> > > Ack -- will pull the rename out into its own patch.
> > >
> > > >
> > > > > +static const struct typec_device_id tbt_typec_id[] = {
> > > > > +     { USB_TYPEC_TBT_SID, USB_TYPEC_TBT_MODE },
> > > > > +     { }
> > > > > +};
> > > > > +MODULE_DEVICE_TABLE(typec, tbt_typec_id);
> > > >
> > > > Now the mode would be the same thing as connector state, which is not
> > > > true. The connector state is supposed to reflect the pin assignment,
> > > > and the mode is the mode index used with the actual VDMs. For example,
> > > > DP alt mode has several different states, but only one mode.
> > > >
> > > > The TBT3 altmode driver will not work with this patch alone, it will
> > > > never bind to the partner TBT3 alt mode because the mode does not
> > > > match.
> > > >
> > > > Can you reorganise this series so that the patch 2/7 comes before this
> > > > one? Then I think you can just use the SVID unless I'm mistaken:
> > > >
> > > >         static const struct typec_device_id tbt_typec_id[] = {
> > > >                 { USB_TYPEC_TBT_SID },
> > > >                 { }
> > > >         };
> > > >         MODULE_DEVICE_TABLE(typec, tbt_typec_id);
> > > >
> > > > Alternatively, just leave it to TYPEC_ANY_MODE for now.
> > > >
> > >
> > > Sure, I'll re-order the patches and get rid of the mode. I'm actually
> > > a bit confused as to how mode is supposed to be used since typec_dp.h
> > > defines USB_TYPEC_DP_MODE=1, typec_tbt.h defines
> > > USB_TYPEC_TBT_MODE=TYPEC_STATE_MODAL and it looks like USB state also
> > > starts from TYPEC_STATE_MODAL and continues.
> > >
> > > Is this documented in the spec somewhere? How should this mode value
> > > be used and shared between USB and various alt-modes? At least the DP
> > > case seems clear because as you said it describes different pin
> > > assignments. However, the term "mode" seems to be overloaded since
> > > it's used in other areas.
> >
> > Well, this is confusing, I admit. One problem is that the term "mode"
> > really means different things depending on the spec. In DP alt mode
> > specification for example, "mode" basically means the same as pin
> > assignment, so not the object position like it does in USB PD and
> > Type-C specifications.
> >
> > But the alt modes are in any case meant to be differentiated from the
> > common USB and accessory modes simply by checking if there is struct
> > altmode or not.
> >
> > So the mux drivers for example can use the "alt" member in struct
> > typec_mux_state to check is the connector meant to enter alt mode, or
> > USB or accessory mode.
> >
> > I.e. if the "alt" member is there, then it's alt mode, and the "mode"
> > member value matches whatever is defined for that specific alt mode.
> >
> > If "alt" is NULL, then connector is in USB mode or accessory mode, and
> > the "mode" member is one of the common modes:
> >
> > enum {
> >         TYPEC_MODE_USB2 = TYPEC_STATE_MODAL,    /* USB 2.0 mode */
> >         TYPEC_MODE_USB3,                        /* USB 3.2 mode */
> >         TYPEC_MODE_USB4,                        /* USB4 mode */
> >         TYPEC_MODE_AUDIO,                       /* Audio Accessory */
> >         TYPEC_MODE_DEBUG,                       /* Debug Accessory */
> > }
> >
> > I hope this answers your question. Maybe this needs to be clarified in
> > this document:
> > https://docs.kernel.org/driver-api/usb/typec.html#multiplexer-demultiplexer-switches
> >
> > ..and the code obviously. Maybe the "mode" member struct
> > typec_mux_state should be renamed to "state"? Though, I'm not sure
> > that improves the situation.
> >
> 
> This does make things clearer -- thank you. Based on the various
> meanings of mode vs state, I think the following will make things
> clearer:
> 
> Let's change |mode| to |mode_index| in `struct typec_altmode_desc`.
> Looking at the Discover SVIDs and Discover Modes response in PD 3.2
> spec, the value we are passing here is actually the mode_index since
> that's what's necessary in the VDM to identify which mode we are
> trying to enter.

Yes, mode_index sounds better.

> |USB_TYPEC_DP_MODE| needs to change to |USB_TYPEC_DP_MODE_INDEX| in typec_dp.h
> |USB_TYPEC_TBT_MODE| should also be |USB_TYPEC_TBT_MODE_INDEX| with a
> value of 1 and we should define a new |TYPEC_TBT_STATE| as an enum
> with base value of TYPEC_STATE_MODAL.
> 
> Getting rid of the mode index for altmode matching makes sense for DP
> and TBT (since both have spec defined standard values) but for
> non-standard modes which might return >1 modes in Discover Modes the
> driver will match for all modes and not just the specific mode like it
> was prior to patch 2 in this series. Do we want to retain that and
> change the TBT driver to only match on mode_index = 1 instead. I have
> no examples of non-standard mode behavior to decide which is the
> better option here.

Let's drop it for now. We can always add it back.

thanks,

> > > > > +static struct typec_altmode_driver tbt_altmode_driver = {
> > > > > +     .id_table = tbt_typec_id,
> > > > > +     .probe = tbt_altmode_probe,
> > > > > +     .remove = tbt_altmode_remove,
> > > > > +     .driver = {
> > > > > +             .name = "typec-thunderbolt",
> > > > > +             .owner = THIS_MODULE,
> > > > > +     }
> > > > > +};
> > > > > +module_typec_altmode_driver(tbt_altmode_driver);
> > > > > +
> > > > > +MODULE_AUTHOR("Heikki Krogerus <heikki.krogerus@linux.intel.com>");
> > > > > +MODULE_LICENSE("GPL");
> > > > > +MODULE_DESCRIPTION("Thunderbolt3 USB Type-C Alternate Mode");
> > > > > diff --git a/include/linux/usb/typec_tbt.h b/include/linux/usb/typec_tbt.h
> > > > > index fa97d7e00f5c..3ff82641f6a0 100644
> > > > > --- a/include/linux/usb/typec_tbt.h
> > > > > +++ b/include/linux/usb/typec_tbt.h
> > > > > @@ -10,7 +10,7 @@
> > > > >  #define USB_TYPEC_TBT_SID            USB_TYPEC_VENDOR_INTEL
> > > > >
> > > > >  /* Connector state for Thunderbolt3 */
> > > > > -#define TYPEC_TBT_MODE                       TYPEC_STATE_MODAL
> > > > > +#define USB_TYPEC_TBT_MODE           TYPEC_STATE_MODAL
> > > >
> > > > I think USB_TYPEC_STATE_TBT would be better. But please change this in
> > > > a separate patch in any case.
> > >
> > > Same question as above about mode vs state :)
> >
> > Well, I was thinking that maybe we should use the term "state" here
> > with the idea that "state" would be something purely kernel specific,
> > and "mode" would then be something defined in a specification... But
> > now I'm not so sure (I don't think it's always clear).
> >
> > Maybe USB_TYPEC_TBT_MODE after all. I'll leave the decision to you.
> >
> > cheers,
> >
> > --
> > heikki

-- 
heikki


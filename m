Return-Path: <linux-kernel+bounces-510670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8127CA3203A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 263D4160DFC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA6320469B;
	Wed, 12 Feb 2025 07:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="trSw1SIe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1E11D86F2;
	Wed, 12 Feb 2025 07:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739346357; cv=none; b=lUCoKBFjEqxMUZPG5OdY6ODnOXUL8JUMfxYmLy41uIMpRAKirVCJ1bXgPt0NveBxYQzB67PEOpxJLmvwANJw2kKYmrahrWNvmkMJimJpQeFaCC7627QDajoqhEJDV0l3YFv1AsxcBTkGTpw906YowMzO8zonpi/8wo2KbhkJNR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739346357; c=relaxed/simple;
	bh=OmoTvEevAQxDxCl0q0yvSSDwzwButvvzNbkWvaAHaFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWs7CSxppoGvVzFTGq1vvSuJfVou1plDQWOMY0R2XRpl3j+EF9rGV5rzulwgjpe+UngZJehNl0MfJLiGRWanT1lGKvcsF+z3RMooNTvQtgGf0xuVYiYIhnD05qtPhtVGgLnvnoj9G5xj3PyYBtkA6z9Txcuz/Aeup8/G+3bhL44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=trSw1SIe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18CADC4CEDF;
	Wed, 12 Feb 2025 07:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739346356;
	bh=OmoTvEevAQxDxCl0q0yvSSDwzwButvvzNbkWvaAHaFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=trSw1SIeK3vmV2kEJ6tqfLvLLIvSnPuuVQwT+X9SOv+YiUBYPZsKoO47ZA7HymFjX
	 sJDFOCcD+Q+5jWjtAh6zdqwWrw+Os5D3i9r8Gsd0Z5b6czE0+YNpkDM2RMRh5WUAru
	 mcNgFOm51cK2YRNB3b8vFxiUfebQkE+aSc8FK1Sw=
Date: Wed, 12 Feb 2025 08:44:44 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Pathak, Asutosh" <asutosh.pathak@intel.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	=?utf-8?Q?=C5=81ukasz?= Bartosik <ukaszb@chromium.org>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Pavan Holla <pholla@chromium.org>,
	"Christian A. Ehrhardt" <lk@c--e.de>,
	Jameson Thies <jthies@google.com>,
	"Katiyar, Pooja" <pooja.katiyar@intel.com>,
	"Jayaraman, Venkat" <venkat.jayaraman@intel.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] usb: typec: ucsi: Command mailbox interface for
 the userspace
Message-ID: <2025021227-married-stunned-759c@gregkh>
References: <20250206141936.1117222-1-heikki.krogerus@linux.intel.com>
 <20250206141936.1117222-2-heikki.krogerus@linux.intel.com>
 <2025020643-federal-uneatable-5da4@gregkh>
 <Z6YE4mJHx1zHNW8d@kuha.fi.intel.com>
 <mpe6hgyqmw5eohrwulzy7ujdrlgccgqxwdjdjq7zmsdhsemzcd@b6q2hu5ezvqv>
 <MN0PR11MB59852E3FEC3E729C9BED8AFA81FD2@MN0PR11MB5985.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN0PR11MB59852E3FEC3E729C9BED8AFA81FD2@MN0PR11MB5985.namprd11.prod.outlook.com>

On Tue, Feb 11, 2025 at 09:21:28PM +0000, Pathak, Asutosh wrote:
> On Tue, Feb 11, 2025 at 01:21:28PM -0700, Pathak Asutosh wrote: 
> > On Fri, Feb 07, 2025 at 03:04:34PM +0200, Heikki Krogerus wrote:
> > > On Thu, Feb 06, 2025 at 03:51:48PM +0100, Greg Kroah-Hartman wrote:
> > > > On Thu, Feb 06, 2025 at 04:19:31PM +0200, Heikki Krogerus wrote:
> > > > > Some of the UCSI commands can be used to configure the
> > > > > entire Platform Policy Manager (PPM) instead of just
> > > > > individual connectors. To allow the user space communicate
> > > > > those commands with the PPM, adding a mailbox interface. The
> > > > > interface is a single attribute file that represents the
> > > > > main "OPM to PPM" UCSI data structure.
> > > > >
> > > > > The mailbox allows any UCSI command to be sent to the PPM so
> > > > > it should be also useful for validation, testing and
> > > > > debugging purposes.
> > > >
> > > > As it's for this type of thing, why not put it in debugfs instead?
> 
> The intend of this sysfs is not limited to validation, testing and
> debugging purposes but rather providing interface for major user space
> application developments.

But that's not what you are saying above.  sysfs is for attributes of a
device, NOT for full device control.  Use a proper api for that that can
be correctly mediated if needed.

> At present we are working on an application/ user space service which 
> will be calling UCSI read/write power level commands. But in future
> there would be more such applications which may require additional
> UCSI commands to use. We wanted to have a common and 
> generic solution - and hence thought of going with sysfs interface.

We can't take new user/kernel apis without a real user, so please hold
off on this series until you have a real user.  Otherwise it is
guaranteed that you will have to change that api based on actually using
it.

> Issue with debugfs is, it is default disabled in release kernels. User has 
> to rebuild the kernel if the application is based on the debugfs interface.
> This will become a bottleneck for wider use of such appliances.

It is up to the distro to enable/disable debugfs, that's not our issue.
debugfs is NOT for normal system operation, so if you want to make this
a proper api for normal users, than no, don't use debugfs, make it a
real api.  Which is probably NOT going to be sysfs.

> > > > > +static ssize_t ucsi_write(struct file *filp, struct kobject *kobj,
> > > > > +			  const struct bin_attribute *attr,
> > > > > +			  char *buf, loff_t off, size_t count)
> > > > > +{
> > > > > +	struct ucsi_sysfs *sysfs = attr->private;
> > > > > +	struct ucsi *ucsi = sysfs->ucsi;
> > > > > +	int ret;
> > > > > +
> > > > > +	u64 *control = (u64 *)&sysfs->mailbox[UCSI_CONTROL];
> > > > > +	u32 *cci = (u32 *)&sysfs->mailbox[UCSI_CCI];
> > > > > +	void *data = &sysfs->mailbox[UCSI_MESSAGE_IN];
> > > > > +
> > > > > +	/* TODO: MESSAGE_OUT. */
> > > > > +	if (off != UCSI_CONTROL || count != sizeof(*control))
> > > > > +		return -EFAULT;
> > > > > +
> > > > > +	mutex_lock(&sysfs->lock);
> > > > > +
> > > > > +	memset(data, 0, UCSI_MAX_DATA_LENGTH(ucsi));
> > > > > +
> > > > > +	/* PPM_RESET has to be handled separately. */
> > > > > +	*control = get_unaligned_le64(buf);
> > > > > +	if (UCSI_COMMAND(*control) == UCSI_PPM_RESET) {
> > > > > +		ret = ucsi_reset_ppm(ucsi, cci);
> > > > > +		goto out_unlock_sysfs;
> > > > > +	}
> > > > > +
> > > > > +	mutex_lock(&ucsi->ppm_lock);
> > > > > +
> > > > > +	ret = ucsi->ops->sync_control(ucsi, *control, cci, NULL, 0);
> > > > > +	if (ret)
> > > > > +		goto out_unlock_ppm;
> > > > > +
> > > > > +	if (UCSI_CCI_LENGTH(*cci) && ucsi->ops->read_message_in(ucsi, data,
> > UCSI_CCI_LENGTH(*cci)))
> > > > > +		dev_err(ucsi->dev, "failed to read MESSAGE_IN\n");
> > > > > +
> > > > > +	ret = ucsi->ops->sync_control(ucsi, UCSI_ACK_CC_CI |
> > UCSI_ACK_COMMAND_COMPLETE,
> > > > > +				      NULL, NULL, 0);
> > > > > +out_unlock_ppm:
> > > > > +	mutex_unlock(&ucsi->ppm_lock);
> > > > > +out_unlock_sysfs:
> > > > > +	mutex_unlock(&sysfs->lock);
> > > > > +
> > > > > +	return ret ?: count;
> > > > > +}
> > > >
> > > > This worries me, any userspace tool can now do this?  What other "bad"
> > > > things can it to the connection?
> > >
> > > Although, there is actually only a limited number of things that you
> > > can do to the connection using UCSI, that is definitely a concern.
> > >
> > > The PPM (which is the EC firmware in most cases) is expected to prevent
> > > any harmful or "unauthorized" UCSI commands from being executed, but
> > > I'm not sure there is any guarantees for that at the moment.
> > >
> Critical power setting related features and options are tightly controlled 
> by PPM/LPM. In such cases, those UCSI command request by user space 
> will be blocked by PPM/LPM and will eventually end of into DoS.

What is "PPM/LPM"?  I don't see that here.

> Moreover, to further mitigate the risk of any malicious attack our 
> understanding is this sysfs interface will be accessible only with root or 
> super user privilege. 

Is it?  You really want normal users being forced to be root in order to
talk to this device?

Make this a real api please, don't try to just do "provide raw access to
the hardware and we will hope any userspace program can get it right",
that way lies madness :)

> Can we still think of going ahead with sysfs interface and double make 
> sure to make this accessible only with root/su privilege to minimize 
> any potential risk of bad uses?

Nope!  Get it right please, once you add it, you can't remove it.

thanks,

greg k-h


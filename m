Return-Path: <linux-kernel+bounces-315817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9621B96C74F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 21:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC9F287914
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829A91E632C;
	Wed,  4 Sep 2024 19:15:39 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EA21E631C;
	Wed,  4 Sep 2024 19:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725477338; cv=none; b=FB4qbcx2zipucOGQFpsbmLT+xVR+cFFEvfi2bV2z/VJ7d15aP5kwNLY8PWbBsdP/2J7nUPZvrjVoLmSxgHIxFpLMOs8U2c3wY7KWckJNNXda+0opBvNWSS+NDi/fthaZJF/wd6b8R8QMi/puC0vlJ+6g14cA7ZKreaCB9qp+slQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725477338; c=relaxed/simple;
	bh=U6uxGWuaMg3qUqvm+QTdfVrTUVaydAYtSpJRs/bS0fA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cq5iAjlYiXWVAoz4gO/IY0nideqGs4nTEBCbUg7zMz+kOBAyK4SfnPvbnwbMaVMETP1g5AxCZsWVucZhVflkFOoK9+tmKI/5BEVOZzWVwgnkVMGhV8jwPtdG2E+xUgXx3xkfOHgYMX+zpjLegfLhaUoTAa2k9yfQbDkYk0WU90Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id DD381140551; Wed,  4 Sep 2024 21:15:26 +0200 (CEST)
Date: Wed, 4 Sep 2024 21:15:26 +0200
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Anurag Bijea <icaliberdev@gmail.com>,
	Christian Heusel <christian@heusel.eu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jameson Thies <jthies@google.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: Re: [PATCH v3] usb: typec: ucsi: Fix busy loop on ASUS VivoBooks
Message-ID: <ZtixzrzsA9bluuL7@cae.in-ulm.de>
References: <20240903181917.617400-1-lk@c--e.de>
 <ZthNkY4MEpUgw3We@kuha.fi.intel.com>
 <ZthnbdKig//kPKgF@cae.in-ulm.de>
 <Zth0pbxJnKYKn8u2@kuha.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zth0pbxJnKYKn8u2@kuha.fi.intel.com>


Hi Heikki,

On Wed, Sep 04, 2024 at 05:54:29PM +0300, Heikki Krogerus wrote:
> On Wed, Sep 04, 2024 at 03:58:05PM +0200, Christian A. Ehrhardt wrote:
> > 
> > Hi Heikki,
> > 
> > On Wed, Sep 04, 2024 at 03:07:45PM +0300, Heikki Krogerus wrote:
> > > On Tue, Sep 03, 2024 at 08:19:17PM +0200, Christian A. Ehrhardt wrote:
> > > > If the busy indicator is set, all other fields in CCI should be
> > > > clear according to the spec. However, some UCSI implementations do
> > > > not follow this rule and report bogus data in CCI along with the
> > > > busy indicator. Ignore the contents of CCI if the busy indicator is
> > > > set.
> > > > 
> > > > If a command timeout is hit it is possible that the EVENT_PENDING
> > > > bit is cleared while connector work is still scheduled which can
> > > > cause the EVENT_PENDING bit to go out of sync with scheduled connector
> > > > work. Check and set the EVENT_PENDING bit on entry to
> > > > ucsi_handle_connector_change() to fix this.
> > > > 
> > > > Reported-by: Anurag Bijea <icaliberdev@gmail.com>
> > > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219108
> > > > Bisected-by: Christian Heusel <christian@heusel.eu>
> > > > Tested-by: Anurag Bijea <icaliberdev@gmail.com>
> > > > Fixes: de52aca4d9d5 ("usb: typec: ucsi: Never send a lone connector change ack")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
> > > > ---
> > > >  drivers/usb/typec/ucsi/ucsi.c | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > > 
> > > > diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> > > > index 4039851551c1..540cb1d2822c 100644
> > > > --- a/drivers/usb/typec/ucsi/ucsi.c
> > > > +++ b/drivers/usb/typec/ucsi/ucsi.c
> > > > @@ -38,6 +38,10 @@
> > > >  
> > > >  void ucsi_notify_common(struct ucsi *ucsi, u32 cci)
> > > >  {
> > > > +	/* Ignore bogus data in CCI if busy indicator is set. */
> > > > +	if (cci & UCSI_CCI_BUSY)
> > > > +		return;
> > > 
> > > I started testing this and it looks like the commands never get
> > > cancelled when the BUSY bit is set. I don't think this patch is the
> > > problem, though. I think the BUSY handling broke earlier, probable in
> > > 5e9c1662a89b ("usb: typec: ucsi: rework command execution functions").
> > > 
> > > I need to look at this a bit more carefully, but in the meantime, can
> > > you try this:
> > > 
> > > 	if (cci & UCSI_CCI_BUSY) {
> > > 		complete(&ucsi->complete);
> > >		return;
> > >         }
> > 
> > I really don't think this is the correct thing to do and it will
> > likely make things worse.
> 
> That was the behaviour before all that command execution refactoring
> this summer. I'm not saying that it's right, but that's how it was.

The code to do that is still there but does not get called because
the ETIMEDOUT error is checked for CCI in ucsi_run_command.
I guess something like this (only compile tested) would fix it:

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 540cb1d2822c..d6d61606bbcf 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -111,15 +111,13 @@ static int ucsi_run_command(struct ucsi *ucsi, u64 command, u32 *cci,
 		size = clamp(size, 0, 16);
 
 	ret = ucsi->ops->sync_control(ucsi, command);
-	if (ret)
-		return ret;
-
-	ret = ucsi->ops->read_cci(ucsi, cci);
-	if (ret)
-		return ret;
+	if (ucsi->ops->read_cci(ucsi, cci))
+		return -EIO;
 
 	if (*cci & UCSI_CCI_BUSY)
 		return -EBUSY;
+	if (ret)
+		return ret;
 
 	if (!(*cci & UCSI_CCI_COMMAND_COMPLETE))
 		return -EIO;


> > A notification with the UCSI_CCI_BUSY bit does _not_ mean that
> > the controller is busy doing other things and cannot complete the
> > command.
> > 
> > Instead it is an indication that the controller _is_ working to
> > complete our command but will take somewhat longer:
> > 
> > Citing:
> > | Note: If a command takes longer than MIN_TIME_TO_RESPOND_WITH_BUSY ms
> > |       for the PPM (excluding PPM to OPM communication latency) to complete,
> > |       then the PPM shall respond to the command by setting the CCI Busy
> > |       Indicator and notify the OPM.
> > |       Subsequently, when the PPM actually completes the command, the
> > |       PPM shall notify the OPM of the outcome of the command via an
> > |       asynchronous notification associated with that command.
> > 
> > Unless I misunderstand what you are trying to do your change would
> > cause us to needlessly abort/cancel every command that takes more than
> > MIN_TIME_TO_RESPOND_WITH_BUSY to complete.
> > 
> > What am I missing?
> 
> The decision to Cancel was made to work around buggy EC firmwares that
> reported BUSY, and then never completed the command. So without that
> Cancel hack, the PPM was stuck on those systems.

Yes fine. But the cancel should be done _after_ the command times
out normally, I guess. Otherwise conforming systems will get there
commands terminated/aborted for no good reason. And this is what
the current code tries to do.

> I don't know what we should do about that hack. We probable could just
> ignore those old systems, and then add quirks for them as needed. But
> I also don't really like what you are proposing in this patch, that we
> basically ignore the BUSY bit completely.

See above. I think that solves both cases nicely.

> Right now I was hoping that we return the behaviour of the driver to
> a point where everything worked as before, and after that start
> improving the driver. That's why I was hoping to hear does the problem
> that you are seeing go away with that approach.
> 
> With which command do you guys get the busy notification?

It happens for all types of commands. I will append debug output where
all commands sent and all CCI values read are printed.

Unfortunately, I don't have direct access to the affected hardware.
I'm just looking into this because one of my changes from earlier
this year caused a regression on that machine. Is this sufficient to
show what's going on?

> In any case, I don't think all those ucsi_*_common() functions give us
> enough room to move here. I feel that the command execution needs to
> be refactored somehow again.

That's your call to make but personally, I like the recent changes
to the interface between ucsi.c and the backend drivers.


Best regards,
Christian


[    5.693255] ucsi_run_command: cmd=0x80010005
[    5.693259] ucsi_sync_control_common: cmd=0x80010005
[    5.775982] ucsi_notify_common: cci=0x18000000	<= BUSY
[    5.812679] ucsi_notify_common: cci=0x18000000	<= BUSY
[    6.409252] ucsi_notify_common: cci=0x80000000
[    6.409374] ucsi_run_command: cci=0x80000000
[    6.409380] ucsi_acknowledge: cmd=0x20004
[    6.409382] ucsi_sync_control_common: cmd=0x20004
[    6.522599] ucsi_notify_common: cci=0x20000000
[    6.522663] ucsi_run_command: cmd=0x6
[    6.522669] ucsi_sync_control_common: cmd=0x6
[    6.636112] ucsi_notify_common: cci=0x30000000	<= MUSY
[    7.162651] ucsi_notify_common: cci=0x80001000
[    7.162786] ucsi_run_command: cci=0x80001000
[    7.162799] ucsi_acknowledge: cmd=0x20004
[    7.162803] ucsi_sync_control_common: cmd=0x20004
[    7.276173] ucsi_notify_common: cci=0x20000000
[    7.276513] ucsi_run_command: cmd=0x10007
[    7.276525] ucsi_sync_control_common: cmd=0x10007
[    7.392806] ucsi_notify_common: cci=0x30000000	<= BUSY
[    7.779633] ucsi_notify_common: cci=0x80000202
[    7.779716] ucsi_run_command: cci=0x80000202
[    7.779728] ucsi_acknowledge: cmd=0x20004
[    7.779732] ucsi_sync_control_common: cmd=0x20004
[    7.892879] ucsi_notify_common: cci=0x20000000
[    7.894566] ucsi_run_command: cmd=0x700010010
[    7.894572] ucsi_sync_control_common: cmd=0x700010010
[    8.109784] ucsi_notify_common: cci=0x30000000	<= BUSY
[    8.336294] ucsi_notify_common: cci=0x80000400
[    8.336446] ucsi_run_command: cci=0x80000400
[    8.336462] ucsi_acknowledge: cmd=0x20004
[    8.336467] ucsi_sync_control_common: cmd=0x20004
[    8.449506] ucsi_notify_common: cci=0x20000000
[    8.449759] ucsi_run_command: cmd=0x300010010
[    8.449773] ucsi_sync_control_common: cmd=0x300010010
[    8.562862] ucsi_notify_common: cci=0x30000000	<= BUSY
[    8.886281] ucsi_notify_common: cci=0x80000c00
[    8.886435] ucsi_run_command: cci=0x80000c00
[    8.886451] ucsi_acknowledge: cmd=0x20004
[    8.886456] ucsi_sync_control_common: cmd=0x20004
[    8.999583] ucsi_notify_common: cci=0x20000000
[    8.999877] ucsi_run_command: cmd=0x100000c
[    8.999890] ucsi_sync_control_common: cmd=0x100000c
[    9.112905] ucsi_notify_common: cci=0x30000000	<= BUSY
[    9.452917] ucsi_notify_common: cci=0x80000c00
[    9.453061] ucsi_run_command: cci=0x80000c00
[    9.453076] ucsi_acknowledge: cmd=0x20004
[    9.453080] ucsi_sync_control_common: cmd=0x20004
[    9.566286] ucsi_notify_common: cci=0x20000000
[    9.566602] ucsi_run_command: cmd=0x10012
[    9.566616] ucsi_sync_control_common: cmd=0x10012
[    9.679618] ucsi_notify_common: cci=0x30000000	<= BUSY
[   10.009413] ucsi_notify_common: cci=0x80000902
[   10.009557] ucsi_run_command: cci=0x80000902
[   10.009575] ucsi_acknowledge: cmd=0x20004
[   10.009579] ucsi_sync_control_common: cmd=0x20004
[   10.122934] ucsi_notify_common: cci=0x20000000
[   10.123533] ucsi_run_command: cmd=0x20007
[   10.123548] ucsi_sync_control_common: cmd=0x20007
[   10.236203] ucsi_notify_common: cci=0x30000000	<= BUSY
[   10.576558] ucsi_notify_common: cci=0x80000204
[   10.576719] ucsi_run_command: cci=0x80000204
[   10.576741] ucsi_acknowledge: cmd=0x20004
[   10.576749] ucsi_sync_control_common: cmd=0x20004
[   10.689685] ucsi_notify_common: cci=0x20000000
[   10.691375] ucsi_run_command: cmd=0x700020010
[   10.691380] ucsi_sync_control_common: cmd=0x700020010
[   10.806201] ucsi_notify_common: cci=0x30000000	<= BUSY
[   11.126253] ucsi_notify_common: cci=0x80000400
[   11.126397] ucsi_run_command: cci=0x80000400
[   11.126410] ucsi_acknowledge: cmd=0x20004
[   11.126414] ucsi_sync_control_common: cmd=0x20004
[   11.239613] ucsi_notify_common: cci=0x20000000
[   11.239931] ucsi_run_command: cmd=0x300020010
[   11.239951] ucsi_sync_control_common: cmd=0x300020010
[   11.452954] ucsi_notify_common: cci=0x30000000	<= BUSY
[   11.689627] ucsi_notify_common: cci=0x80000c00
[   11.689786] ucsi_run_command: cci=0x80000c00
[   11.689802] ucsi_acknowledge: cmd=0x20004
[   11.689807] ucsi_sync_control_common: cmd=0x20004
[   11.802981] ucsi_notify_common: cci=0x20000000
[   11.803269] ucsi_run_command: cmd=0x200000c
[   11.803282] ucsi_sync_control_common: cmd=0x200000c
[   11.916252] ucsi_notify_common: cci=0x30000000	<= BUSY
[   12.239694] ucsi_notify_common: cci=0x80000c00
[   12.239850] ucsi_run_command: cci=0x80000c00
[   12.239866] ucsi_acknowledge: cmd=0x20004
[   12.239872] ucsi_sync_control_common: cmd=0x20004
[   12.353002] ucsi_notify_common: cci=0x20000000
[   12.353314] ucsi_run_command: cmd=0x20012
[   12.353328] ucsi_sync_control_common: cmd=0x20012
[   12.466323] ucsi_notify_common: cci=0x30000000	<= BUSY
[   12.813075] ucsi_notify_common: cci=0x80000904
[   12.813266] ucsi_run_command: cci=0x80000904
[   12.813296] ucsi_acknowledge: cmd=0x20004
[   12.813305] ucsi_sync_control_common: cmd=0x20004
[   12.929618] ucsi_notify_common: cci=0x20000000
[   12.929652] ucsi_run_command: cmd=0xdbe70005
[   12.929657] ucsi_sync_control_common: cmd=0xdbe70005
[   13.043047] ucsi_notify_common: cci=0x30000000	<= BUSY
[   13.486398] ucsi_notify_common: cci=0x80000000
[   13.486526] ucsi_run_command: cci=0x80000000
[   13.486545] ucsi_acknowledge: cmd=0x20004
[   13.486553] ucsi_sync_control_common: cmd=0x20004
[   13.599633] ucsi_notify_common: cci=0x20000000
[   53.859700] ucsi_notify_common: cci=0x2
[   53.859732] ucsi_run_command: cmd=0x10012
[   53.859740] ucsi_sync_control_common: cmd=0x10012
[   53.973294] ucsi_notify_common: cci=0x80000902
[   53.973327] ucsi_run_command: cci=0x80000902
[   53.973332] ucsi_acknowledge: cmd=0x30004
[   53.973336] ucsi_sync_control_common: cmd=0x30004
[   54.096216] ucsi_notify_common: cci=0x80000902
[   54.209461] ucsi_notify_common: cci=0x80000902
[   54.523010] ucsi_notify_common: cci=0x4
[   59.059426] ucsi_acpi USBC000:00: ucsi_handle_connector_change: GET_CONNECTOR_STATUS failed (-110)
[   59.059504] ucsi_acpi USBC000:00: ucsi_handle_connector_change entered without EVENT_PENDING
[   59.059511] ucsi_run_command: cmd=0x10012
[   59.059518] ucsi_sync_control_common: cmd=0x10012
[   59.176228] ucsi_notify_common: cci=0x10000004	<= BUSY
[   59.512840] ucsi_notify_common: cci=0x80000902
[   59.512981] ucsi_run_command: cci=0x80000902
[   59.512997] ucsi_acknowledge: cmd=0x30004
[   59.513003] ucsi_sync_control_common: cmd=0x30004
[   59.626210] ucsi_notify_common: cci=0x20000000
[   59.869608] ucsi_notify_common: cci=0x4
[   59.869629] ucsi_run_command: cmd=0x20012
[   59.869634] ucsi_sync_control_common: cmd=0x20012
[   59.983161] ucsi_notify_common: cci=0x80000904
[   59.983187] ucsi_run_command: cci=0x80000904
[   59.983191] ucsi_acknowledge: cmd=0x30004
[   59.983194] ucsi_sync_control_common: cmd=0x30004
[   60.106197] ucsi_notify_common: cci=0x80000904
[   60.219501] ucsi_notify_common: cci=0x80000904
[   65.032712] ucsi_acpi USBC000:00: ucsi_handle_connector_change: GET_CONNECTOR_STATUS failed (-110)
[   65.032735] ucsi_run_command: cmd=0x20012
[   65.032742] ucsi_sync_control_common: cmd=0x20012
[   65.149825] ucsi_notify_common: cci=0x10000000	<= BUSY
[   65.466178] ucsi_notify_common: cci=0x80000904
[   65.466303] ucsi_run_command: cci=0x80000904
[   65.466314] ucsi_acknowledge: cmd=0x30004
[   65.466317] ucsi_sync_control_common: cmd=0x30004
[   65.579642] ucsi_notify_common: cci=0x20000000
[  452.229465] ucsi_notify_common: cci=0x2
[  452.229487] ucsi_run_command: cmd=0x10012
[  452.229492] ucsi_sync_control_common: cmd=0x10012
[  452.343183] ucsi_notify_common: cci=0x80000902
[  452.343213] ucsi_run_command: cci=0x80000902
[  452.343219] ucsi_acknowledge: cmd=0x30004
[  452.343222] ucsi_sync_control_common: cmd=0x30004
[  452.466212] ucsi_notify_common: cci=0x80000902
[  452.579621] ucsi_notify_common: cci=0x80000902
[  457.566115] ucsi_acpi USBC000:00: ucsi_handle_connector_change: GET_CONNECTOR_STATUS failed (-110)
[  457.566164] ucsi_run_command: cmd=0x10012
[  457.566170] ucsi_sync_control_common: cmd=0x10012
[  457.682904] ucsi_notify_common: cci=0x10000000	<= BUSY
[  458.022943] ucsi_notify_common: cci=0x80000902
[  458.022997] ucsi_run_command: cci=0x80000902
[  458.023006] ucsi_acknowledge: cmd=0x30004
[  458.023012] ucsi_sync_control_common: cmd=0x30004
[  458.313052] ucsi_notify_common: cci=0x20000000
[  459.216302] ucsi_notify_common: cci=0x2
[  459.216334] ucsi_run_command: cmd=0x10012
[  459.216342] ucsi_sync_control_common: cmd=0x10012
[  459.329962] ucsi_notify_common: cci=0x80000902
[  459.330004] ucsi_run_command: cci=0x80000902
[  459.330012] ucsi_acknowledge: cmd=0x30004
[  459.330019] ucsi_sync_control_common: cmd=0x30004
[  459.454316] ucsi_notify_common: cci=0x20000000
[  459.629445] ucsi_notify_common: cci=0x80000902
[  459.629464] ucsi_run_command: cmd=0x10012
[  459.629468] ucsi_sync_control_common: cmd=0x10012
[  459.749499] ucsi_notify_common: cci=0x10000004	<= BUSY
[  460.052875] ucsi_notify_common: cci=0x80000902
[  460.052904] ucsi_run_command: cci=0x80000902
[  460.052908] ucsi_acknowledge: cmd=0x30004
[  460.052911] ucsi_sync_control_common: cmd=0x30004
[  460.169506] ucsi_notify_common: cci=0x80000902
[  460.212808] ucsi_notify_common: cci=0x80000902
[  460.422857] ucsi_notify_common: cci=0x4
[  465.246068] ucsi_acpi USBC000:00: ucsi_handle_connector_change: GET_CONNECTOR_STATUS failed (-110)
[  465.246100] ucsi_run_command: cmd=0x10012
[  465.246106] ucsi_sync_control_common: cmd=0x10012
[  465.359485] ucsi_notify_common: cci=0x10000004	<= BUSY
[  465.682873] ucsi_notify_common: cci=0x80000902
[  465.682995] ucsi_run_command: cci=0x80000902
[  465.683007] ucsi_acknowledge: cmd=0x30004
[  465.683011] ucsi_sync_control_common: cmd=0x30004
[  465.796454] ucsi_notify_common: cci=0x20000000
[  466.062929] ucsi_notify_common: cci=0x4
[  466.062948] ucsi_run_command: cmd=0x20012
[  466.062953] ucsi_sync_control_common: cmd=0x20012
[  466.176432] ucsi_notify_common: cci=0x80000904
[  466.176460] ucsi_run_command: cci=0x80000904
[  466.176464] ucsi_acknowledge: cmd=0x30004
[  466.176467] ucsi_sync_control_common: cmd=0x30004
[  466.299480] ucsi_notify_common: cci=0x80000904
[  466.412917] ucsi_notify_common: cci=0x80000904
[  471.219358] ucsi_acpi USBC000:00: ucsi_handle_connector_change: GET_CONNECTOR_STATUS failed (-110)
[  471.219378] ucsi_run_command: cmd=0x20012
[  471.219385] ucsi_sync_control_common: cmd=0x20012
[  471.429768] ucsi_notify_common: cci=0x10000000	<= BUSY
[  471.656179] ucsi_notify_common: cci=0x80000904
[  471.656296] ucsi_run_command: cci=0x80000904
[  471.656308] ucsi_acknowledge: cmd=0x30004
[  471.656312] ucsi_sync_control_common: cmd=0x30004
[  471.769559] ucsi_notify_common: cci=0x20000000
[  473.739477] ucsi_notify_common: cci=0x4
[  473.739499] ucsi_run_command: cmd=0x20012
[  473.739504] ucsi_sync_control_common: cmd=0x20012
[  473.853143] ucsi_notify_common: cci=0x80000904
[  473.853171] ucsi_run_command: cci=0x80000904
[  473.853176] ucsi_acknowledge: cmd=0x30004
[  473.853179] ucsi_sync_control_common: cmd=0x30004
[  473.976279] ucsi_notify_common: cci=0x80000904
[  474.092949] ucsi_notify_common: cci=0x80000904
[  477.966188] ucsi_notify_common: cci=0x2
[  478.899403] ucsi_acpi USBC000:00: ucsi_handle_connector_change: GET_CONNECTOR_STATUS failed (-110)
[  478.899423] ucsi_run_command: cmd=0x20012
[  478.899430] ucsi_sync_control_common: cmd=0x20012
[  479.012882] ucsi_notify_common: cci=0x80000904
[  479.012915] ucsi_run_command: cci=0x80000904
[  479.012919] ucsi_acknowledge: cmd=0x30004
[  479.012923] ucsi_sync_control_common: cmd=0x30004
[  479.133919] ucsi_notify_common: cci=0x80000904
[  479.259431] ucsi_notify_common: cci=0x80000904
[  479.489537] ucsi_notify_common: cci=0x2
[  484.232628] ucsi_acpi USBC000:00: ucsi_handle_connector_change: GET_CONNECTOR_STATUS failed (-110)
[  484.232652] ucsi_run_command: cmd=0x20012
[  484.232658] ucsi_sync_control_common: cmd=0x20012
[  484.349424] ucsi_notify_common: cci=0x10000002	<= BUSY
[  484.686205] ucsi_notify_common: cci=0x80000904
[  484.686334] ucsi_run_command: cci=0x80000904
[  484.686348] ucsi_acknowledge: cmd=0x30004
[  484.686352] ucsi_sync_control_common: cmd=0x30004
[  484.802713] ucsi_notify_common: cci=0x20000000
[  485.082805] ucsi_notify_common: cci=0x2
[  485.082825] ucsi_run_command: cmd=0x10012
[  485.082830] ucsi_sync_control_common: cmd=0x10012
[  485.196271] ucsi_notify_common: cci=0x80000902
[  485.196295] ucsi_run_command: cci=0x80000902
[  485.196298] ucsi_acknowledge: cmd=0x30004
[  485.196301] ucsi_sync_control_common: cmd=0x30004
[  485.322778] ucsi_notify_common: cci=0x80000902
[  485.436061] ucsi_notify_common: cci=0x80000902


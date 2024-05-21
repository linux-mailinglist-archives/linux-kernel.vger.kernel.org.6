Return-Path: <linux-kernel+bounces-184922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFF48CADD2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 14:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC6771C22205
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 12:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0A97581A;
	Tue, 21 May 2024 12:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="SZ5+9EhA"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F96255C29
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 12:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716292888; cv=none; b=bWpIzkJoy0QEEHyB/rDVSkgZ4M0vypm8kqR9Q9i04mylZC6pKKI4NKVFUlTGZ0CH23k+7h2iGXSI/eVEFMce+cnZtAlOu3T9yhx1Y94ovMk2alOQbg7J/DZgEmBt2dt4q/eZZ9BdHanZuIsWo2EmlT+RJtsKYyBEF6T9caIbg8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716292888; c=relaxed/simple;
	bh=/ejDAusWIixeV1PnvJsPCxICtT7jec04kyccweP3tEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eou2Z8wmh3X/TBkxG0ddFcU/J/vraNZWorSmuclrZjPuzjm6d7i01Rfd2Lze/hO5TWj1RotiZdsHDM9PIAbWotXN0wvt7hPFCAZ70xC2SNodn7qqFaGoyEI3lO8kXCKX/AePcUhwns9dke2eufqKWaDwM2dhCMWWBINMaJBbhGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=SZ5+9EhA; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-354c84d4604so514624f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 05:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1716292885; x=1716897685; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dMyJYwXz6twfKeFoo9zvJ5Xbyx3tpsAON73QGLuOcbs=;
        b=SZ5+9EhAetSp5Mdme6ffuT4/WxOoI9dLLRBTiJEN2P0LttjutSii6nJln/Oq6hV88P
         wBGNPu8n8gE3ZGOaj/qnj4sY+truD655JvrG35E9oR4HSMde+P18IIakT8soRmnGa8+H
         oD9YYNBj44BDmLAjCzYCL8I/+tk/lScMy98B4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716292885; x=1716897685;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dMyJYwXz6twfKeFoo9zvJ5Xbyx3tpsAON73QGLuOcbs=;
        b=CdXaKjAWCNOHkZUAhA9XvTvTLJYFCH6YwKvxUuYkG8Ivvfrcrk4rurEuswtViBhSgu
         toMeGrKblL++TFd4FXLe59fvue/KBFUuDXl1PscUe1jTeIkFXyU7iE9vKxD83596/BfU
         pLXw67UCM/HNfy5hLg7oj3QHMajLu31GXLkc4nCP3g4HcvkgoLfezNne0aYPTu1YhwrX
         ABf+kKrRzEyPyE0/9NqvezRdfFJBmYyrrrsejBCURa4sNEbejh6flBd60h8gOEJt6G8v
         fVwEQ5NFH4j40HZG9PWy0749MNGi3DiTDQriyScyOLIeiKmCf3gu/j/LhP0ZJkM5AcsV
         xMnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfaAhWXYSiJmdhwL8CIYaE67G0mK4aQbKKZIEXZSN1z0cGqnyBXqKYKKPlc3ZvPuGLPKQip3JEE8IHskQtcQ7RyzkuW2zIMWT6z/0Z
X-Gm-Message-State: AOJu0Ywq9WboYKdmBkPkx5TJPTK9MrG/l3MUwdUnvGqaSpglQDVLxN1f
	0gVtkg8ohlY7gTG3eH+ubMbXz8hxJeqCrlkgZ8dYthw979e2p5sR/VP9YI8XYrc=
X-Google-Smtp-Source: AGHT+IGBxqXODfk5lDZZclt4Locdjaf51kPYJvvfackmeuxQBV6aeqRJ8vgQtbSjF1GQbZF7JlrOvg==
X-Received: by 2002:a05:600c:3c9d:b0:419:f4d6:5044 with SMTP id 5b1f17b1804b1-41feac48bbemr240593155e9.2.1716292884791;
        Tue, 21 May 2024 05:01:24 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccbe9011sm461233515e9.7.2024.05.21.05.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 05:01:22 -0700 (PDT)
Date: Tue, 21 May 2024 14:01:19 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>,
	Paul Kocialkowski <contact@paulk.fr>,
	=?iso-8859-1?Q?Herv=E9?= Codina <herve.codina@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v2 0/5] Add support for GE SUNH hot-pluggable connector
 (was: "drm: add support for hot-pluggable bridges")
Message-ID: <ZkyND17TGj6y0Wjq@phenom.ffwll.local>
Mail-Followup-To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>,
	Paul Kocialkowski <contact@paulk.fr>,
	=?iso-8859-1?Q?Herv=E9?= Codina <herve.codina@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>
References: <20240510-hotplug-drm-bridge-v2-0-ec32f2c66d56@bootlin.com>
 <ZkYIeWzYyxkURS79@phenom.ffwll.local>
 <20240520140148.26b91240@booty>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240520140148.26b91240@booty>
X-Operating-System: Linux phenom 6.8.9-amd64 

On Mon, May 20, 2024 at 02:01:48PM +0200, Luca Ceresoli wrote:
> Hello Daniel,
> 
> On Thu, 16 May 2024 15:22:01 +0200
> Daniel Vetter <daniel@ffwll.ch> wrote:
> 
> > Apologies for missing v1 ...
> > 
> > On Fri, May 10, 2024 at 09:10:36AM +0200, Luca Ceresoli wrote:
> > > DRM hotplug bridge driver
> > > =========================
> > > 
> > > DRM natively supports pipelines whose display can be removed, but all the
> > > components preceding it (all the display controller and any bridges) are
> > > assumed to be fixed and cannot be plugged, removed or modified at runtime.
> > > 
> > > This series adds support for DRM pipelines having a removable part after
> > > the encoder, thus also allowing bridges to be removed and reconnected at
> > > runtime, possibly with different components.
> > > 
> > > This picture summarizes the  DRM structure implemented by this series:
> > > 
> > >  .------------------------.
> > >  |   DISPLAY CONTROLLER   |
> > >  | .---------.   .------. |
> > >  | | ENCODER |<--| CRTC | |
> > >  | '---------'   '------' |
> > >  '------|-----------------'
> > >         |
> > >         |DSI            HOTPLUG
> > >         V              CONNECTOR
> > >    .---------.        .--.    .-.        .---------.         .-------.
> > >    | 0 to N  |        | _|   _| |        | 1 to N  |         |       |
> > >    | BRIDGES |--DSI-->||_   |_  |--DSI-->| BRIDGES |--LVDS-->| PANEL |
> > >    |         |        |  |    | |        |         |         |       |
> > >    '---------'        '--'    '-'        '---------'         '-------'
> > > 
> > >  [--- fixed components --]  [----------- removable add-on -----------]
> > > 
> > > Fixed components include:
> > > 
> > >  * all components up to the DRM encoder, usually part of the SoC
> > >  * optionally some bridges, in the SoC and/or as external chips
> > > 
> > > Components on the removable add-on include:
> > > 
> > >  * one or more bridges
> > >  * a fixed connector (not one natively supporting hotplug such as HDMI)
> > >  * the panel  
> > 
> > So I think at a high level this design approach makes sense,
> 
> Good starting point :)
> 
> > but the
> > implementation needs some serious thought. One big thing upfront though,
> > we need to have a clear plan for the overlay hotunload issues, otherwise
> > trying to make drm bridges hotpluggable makes no sense to me. Hotunload is
> > very, very tricky, full of lifetime issues, and those need to be sorted
> > out first or we're just trying to build a castle on quicksand.
> > 
> > For bridges itself I don't think the current locking works. You're trying
> > to really cleverly hide it all behind a normal-looking bridge driver, but
> > there's many things beyond that which will blow up if bridges just
> > disappear. Most importantly the bridge states part of an atomic update.
> 
> Surely possible as atomic updates are definitely not stimulated in my
> use case. Can you recommend any testing tools to be able to trigger any
> issues?

Uh really hard ... You'd need to create an atomic commit that's blocked on
a sync_file in-fence (so that you can extend the race window). And then
hotunplug the bridge chain _before_ you signal that fence.

That's not going to cover all possible races, but at least a large chunk
of the really big ones.

> The main setups I used for my testing so far are 'modetest -s' for my
> daily work and a simple weston setup to periodically test a complete
> user space stack.
> 
> > Now in drm we have drm_connector as the only hotunpluggable thing, and it
> > took years to sort out all the issues. I think we should either model the
> > bridge hotunplug locking after that, or just outright reuse the connector
> > locking and lifetime rules. I much prefer the latter personally.
> > 
> > Anyway the big issues:
> > 
> > - We need to refcount the hotpluggable bridges, because software (like
> >   atomic state updates) might hang onto pointers for longer than the
> >   bridge physically exists. Assuming that you can all tear it down
> >   synchronously will not work.
> > 
> >   If we reuse connector locking/lifetime then we could put the
> >   hotpluggable part of the bridge chain into the drm_connector, since that
> >   already has refcounting as needed. It would mean that finding the next
> >   bridge in the chain becomes a lot more tricky though. With that model
> >   we'd create a new connector every time the bridge is hotplugged, which I
> >   think is also the cleaner model (because you might plug in a hdmi
> >   connector after a panel, so things like the connector type change).
> 
> I have been investigating the option of adding/removing a connector
> based on hot-plug/unplug events initially, see my reply to Maxime after
> v1 [0]:
> 
> > The first approach is based on removing the drm_connector. My laptop
> > uses the i915 driver, and I have observed that attaching/removing a
> > USB-C dock with an HDMI connector connected to a monitor, a new
> > drm_connector appears/disappears for the card. User space gets notified
> > and the external monitor is enabled/disabled, just the way a desktop
> > user would expect, so this is possible. I had a look at the driver but
> > how this magic happens was not clear to me honestly.
> 
> So if you could point to where/how this is done, I would certainly
> reconsider that.

Right now only the dp mst code uses hotplug/unplug (like you've observed
in your testing with i915, usb-c docks are generally all dp mst). For code
reading it might be best to start with the i915 dp mst code and then go
through the helpers.

> > - No notifiers please. The create a locking mess with inversions, and
> >   especially for hotunplug they create the illusion that you can
> >   synchronously keep up to date with hardware state. That's not possible.
> >   Fundamentally all bridge drivers which might be hotunplugged need to be
> >   able to cope with the hardware disappearing any momemnt.
> 
> Can you clarify this point? I'm sorry I fail to understand the
> relationship between the use of notifiers and the ability of bridge
> drivers to cope with hardware disappearing.
> 
> In this patch, the hotplug-bridge uses notifiers to be informed when
> the following bridge is disappearing: which other way would you suggest
> to make the hotplug-bridge aware of that? OTOH the hotplug-bridge is
> not meant to disappear, and it has no actual hardware that can go away,
> being just a mechanical connector.

Yeah you need code to handle that. My point is that using a notifier is
the wrong design, because the notifier has it's own locking. Which tends
to get in the way.

Instead I think that code should be directly in core bridge code (I don't
see the benefit of having this entirely in a separate driver), using drm
locking to make sure there's no races.

> On the opposite side, the following bridges are physically removable
> and so their drivers will have to be fixed (if needed) to work when
> removal happens, but I don't see how that relates to the DRM core
> emitting a notification of such bridges being removed.

Yeah it's not directly related, just my experience that people assume
notifiers provide you more synchronization and race-preventation than they
really do. So it's better to hand-roll to make it all really explicit.

> > - Related to this: You're not allowed to shut down hardware behind the
> >   user's back with drm_atomic_helper_shutdown. We've tried that approach
> >   with dp mst, it really pisses off userspace when a page_flip that it
> >   expected to work doesn't work.
> > 
> > - There's also the design aspect that in atomic, only atomic_check is
> >   allowed to fail, atomic_commit must succeed, even when the hardware is
> >   gone. Using connectors and their refcounting should help with that.
> 
> IIUC here you are suggesting again to remove the connector instead of
> marking it "disconnected". So, as above, pointers on how that is
> achieved would be helpful.

See dp mst code. It's complex unfortunately, so there's some reading
involved :-/
>
> > - Somewhat aside, but I noticed that the bridge->atomic_reset is in
> >   drm_bridge_attach, and that's kinda the wrong place. It should be in
> >   drm_mode_config_reset, like all the other ->atomic_reset hooks. That
> >   would make it a lot clearer that we need to figure out who/when
> >   ->atomic_reset should be called for hotplugged bridges, maybe as part of  
> >   connector registration when the entire bridge and it's new connector is
> >   assembled?
> > 
> > - Finally this very much means we need to rethink who/how the connector
> >   for a bridge is created. The new design is that the main driver creates
> >   this connector, once the entire bridge exists. But with hotplugging this
> >   gets a lot more complicated, so we might want to extract a pile of that
> >   encoder related code from drivers (same way dp mst helpers take care of
> >   connector creation too, it's just too much of a mess otherwise).
> > 
> >   The current bridge chaining infrastructure requires a lot of hand-rolled
> >   code in each bridge driver and the encoder, so that might be a good
> >   thing anyway.
> > 
> > - Finally I think the entire bridge hotplug infrastructure should be
> >   irrespective of the underlying bus. Which means for the mipi dsi case we
> >   might also want to look into what's missing to make mipi dsi
> >   hotunpluggable, at least for the case where it's a proper driver. I
> >   think we should ignore the old bridge model where driver's stitched it
> >   all toghether using the component framework, in my opinion that approach
> >   should be deprecated.
> 
> The DSI side was one of my headaches on writing this driver, and I
> must say I dislike the code in hotplug_bridge_dsi_attach(), with the
> need for an initial "dummy" attach and detach the first time. At first
> sight I think we need a .update_format callback in struct
> mipi_dsi_host_ops so the DSI host is aware of a format change.
> 
> Right now there are DSI host drivers which keep a copy of the struct
> mipi_dsi_device pointer and read the format from there when starting a
> stream (e.g. the tc358768.c driver [1]). That somewhat provides a way
> to react to format changes, but keeping a pointer is bad when the DSI
> device hot-unplugs, and the new format won't be seen until a
> disable/enable cycle. So a new callback looks more robust overall.
> 
> Any opinion about this?

Yeah I don't like the code either.

What might help for prototyping is if you start with a hotpluggeable
bridge where the bridge is a i2c device. That way I think we should be
able to benefit from the driver bind/unbind code that exists already.
Although there's going to be issues with i2c hotunplug too in i2c core
code.

Then lift whatever we learn there to our dsi code. But essentially I think
we should model the driver core model a lot more, so I guess you could use
any hotunplug capable bus as a template. Usb might be closest, since
that's also a packet/message based interface, mostly at least?

> > - Finally I think we should have a lot of safety checks, like only bridges
> >   which declare themselve to be hotunplug safe should be allowed as a part
> >   of the hotpluggable bridge chain part. All others must still be attached
> >   before the entire driver is registered with drm_dev_register.
> 
> I'm fine with the principle of a "HOTPLUG" flag.
> 
> I wonder how that should be implemented, though. Based on my (surely
> simplistic) understanding, right now bridges can be both added and
> removed, but only in a specific sequence:
> 
>  1. add all bridges
>  2. use the card
>  3. remove all bridges
>  4. EOF
> 
> We'd need to change to allow:
> 
>  1. add fixed bridges (including hotplug-bridge)
>  2. add bridges on removable add-on
>  3. use card
>  4. remove bridges on removable add-on
>  5. optionally goto 2
>  6. remove fixed bridges (including hotplug-bridge)
>  7. EOF
> 
> One naïve idea is that the DRM core keeps a flag whenever any fixed
> bridge (no HOTLPUG flag) is removed and when that happens forbid adding
> bridges as we are now at line 5.

If a fixed bridge is removed while the driver is still in use (i.e. before
drm_dev_unregister is called), that's a driver bug. Would be good to catch
that, which is why I think a lot of all the bridge hotplug handling should
be in core bridge code and not the separate hotplug driver, so that we can
enforce all these constraints.

Also conceptually 3 can happen before 2 (but also before), and that's how
dp mst works too. It does add all kinds of complications though ...

> Aside for tons of subtleties I'm surely missing, does this look a
> proper approach? I'd not be surprised if there is something better and
> more solid.

Yeah roughly. If you look through dp mst code then that also adds all
kinds of structures (since dp mst is a routed network really), not just
the connectors. They also all come with refcounts (because the network is
a tree), but like I said I think for your case we can avoid the per-bridge
refcounts by relying on the connector refcount we have already.

But I might be overlooking something, and we need refcounting for each
bridge like dp mst also needs refcounting for all its internal structures
that map the entire hotpluggable display chain. If you want to read some
dp mst code, these internal structures are ports/branches with struct
drm_dp_mst_branch/port.

> >   Or that we only allow bridges with the NO_CONNECTOR flag for
> >   drm_bridge_attach.
> > 
> > There's probably a pile more fundamental issues I've missed, but this
> > should get a good discussion started.
> 
> Sure, I think it has.
> 
> Bottom line, I'm clearly not seeing some issues that need to be
> considered, and that do not show up for my use case. Based on my
> limited DRM knowledge, this was expected, and I'm glad to work on those
> issues with some practical indications about the path forward.

Yeah for learning I think dp mst is best. It's a bit complex, but since
you have a dock you should be able to play around and experiment with the
code with some real hardware.

That should help to get a bit a feel for the complexity, since lots of
opportunities for you to ask why/how locking/refcounting is used and
against which potential issue they protect.

Cheers, Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch


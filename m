Return-Path: <linux-kernel+bounces-240184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C924926A00
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 502F61C218A1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65505191F69;
	Wed,  3 Jul 2024 21:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o7n3VSsG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C096010A1F;
	Wed,  3 Jul 2024 21:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720040906; cv=none; b=Bz6lKt7dPzw/I2GejJI6kpvNhhEJMMM3V1G3t2giA7SjD94FQun4Tu6MOIuLVkqbO2TDpee9WNg7mXuciCsegPfTMWSw7ZD18CCcDuAIghGylTEDAZLbeeBJvz0yaV7IvHn+XVoeuvZJfpFEsE3kImjsglyW1t3XAJL8X2X+2sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720040906; c=relaxed/simple;
	bh=h2y6D4xg7fOTYEO/GYeowuoGr3vvuikNSm8roWYbhyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C19XXi/W5sGhPHZIvWsyXcxef0Lx0/hfjuFni3+eV+vNIIQsqlts+1tXQiu7iTODoaqh00QvdAe8X80A77r7+58ljOPcI1jQsGKwFSb4lNRvbRAm5xp1c4TAwsEq8SxhxKoJmdAF2fwrcPpWs/Gi8garQvNqxAbzW3RSvMPJjjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o7n3VSsG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E865C2BD10;
	Wed,  3 Jul 2024 21:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720040906;
	bh=h2y6D4xg7fOTYEO/GYeowuoGr3vvuikNSm8roWYbhyQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=o7n3VSsGj4VskKHjZhW3hkM1pX5NUYea1iyIRejW8MOBI5kscO5DAEKXW0qHKbjJ4
	 Lu0rJi5OLJ9e3Ghs7Sy2i/zmaHKdrmwaOUPrYGkd/T/g4mBQADFZEHWyNvSIohkNcE
	 zwrl1tIlJGd+fgrqEkyXOuqirq8Jnp2HTIoasHcTuESGgSag7/tSOU+yHrjQRNM4D7
	 QNH4EQjUICrKS1h96+h4EleO2vGGTspAwSVa1V1x8GYMYtOIalCfo34U+mLPVP+vPL
	 S2q/ydeT8oqyJGC73RR9hArhcST85kTQRHd6dHi0hhFjz86Tek19f1hRqU/HZICm48
	 Zs4lWqxlHxeuA==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52cdfb69724so7094099e87.1;
        Wed, 03 Jul 2024 14:08:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVETTbEQYXN7IZodFrN6V7OEATVjpXlZX/7ROHHYj+pdQUmRLsCvXAEyGg09/131nz/GQDuz7e1/hCnrSPW7dIaO08z7jiPdG3COjN/v1GOwsgwDG40j31An8iIlpfpyJDWdNaSNoRa+w==
X-Gm-Message-State: AOJu0YxrFoyLPJFUnd5owTVQ3jxALAz+6JBB/t/tGXkI2v2igf7MCYzT
	6ABYhfTnzlYTV36WbbdH2F16esYQKaEm+WoGP1enLs3hXh00osw6zsw1bc2schTg7xYPVz/EsqL
	FnYaujdsymZZ0ot8V4RbiE+KOJQ==
X-Google-Smtp-Source: AGHT+IGZGu0eLh0zGN8Vy3mUQHEMmQ0CIQ+xyDAOJUoaTNju5f4e930Vi/V/6TBYmA+X0cvmO1Tg1lhDum5uhrMR2dY=
X-Received: by 2002:a05:6512:3b12:b0:52c:df6f:a66 with SMTP id
 2adb3069b0e04-52e8273f716mr8306199e87.58.1720040904267; Wed, 03 Jul 2024
 14:08:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624232122.3cfe03f8@booty> <CAL_Jsq+=mGEJXsjq1UZFMJtHko_z+doiFMXnx9K7exDuznymSA@mail.gmail.com>
 <20240627145741.77ddccbf@booty>
In-Reply-To: <20240627145741.77ddccbf@booty>
From: Rob Herring <robh@kernel.org>
Date: Wed, 3 Jul 2024 15:08:11 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ1aKP=9VdAxjWvjZdyD0tYPhKSZKa1kAnQwPv4sBpbtA@mail.gmail.com>
Message-ID: <CAL_JsqJ1aKP=9VdAxjWvjZdyD0tYPhKSZKa1kAnQwPv4sBpbtA@mail.gmail.com>
Subject: Re: Fixing property memory leaks on device tree overlay removal
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Conor Dooley <conor@kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Saravana Kannan <saravanak@google.com>, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 6:57=E2=80=AFAM Luca Ceresoli <luca.ceresoli@bootli=
n.com> wrote:
>
> Hello Rob,
>
> thanks for you detailed answer. See below my comments.
>
> On Tue, 25 Jun 2024 11:02:12 -0600
> Rob Herring <robh@kernel.org> wrote:
>
> > On Mon, Jun 24, 2024 at 3:21=E2=80=AFPM Luca Ceresoli <luca.ceresoli@bo=
otlin.com> wrote:
> > >
> > > Hello,
> > >
> >
> > This is a great summary of the issues with further overlay support.
>
> Thanks. And thanks to my colleague Herv=C3=A9 as well, who worked togethe=
r
> with me on this analysis, giving invaluable help, apologies for not
> having mentioned him initially!
>
> > > device tree overlays are implemented in the kernel since a long time,
> > > but there is currently no code using them, except unittest. The
> > > largest (in terms of code lines involved) blocker for enabling it is =
the
> > > memory leak of properties that happen on overlay removal [0]. The
> > > kernel warns about it on overlay insertion:
> > >
> > >   OF: overlay: WARNING: memory leak will occur if overlay removed, pr=
operty: /...
> >
> > Maybe this needs to just be finer-grained ansmarter. For example, we
> > know when we've leaked pointers (because you found the cases below).
> > We could set a flag in the node when that happens and then warn when
> > removing the overlay.
>
> Fun, this is one of the options we considered. This leads to asking what
> exactly we want, and which problem we want to fix.
>
> As I understand it, full removal of any struct property pointer outside
> of the OF core is a requirement for the configfs overlay interface.
> However what is required for having specific drivers to load/unload
> overlays is not entirely clear to me after your reply. Our plan aims at
> removing all the property-leaking APIs, which would give the best safety
> guarantee, but from your comments (here and below) I infer it's not all
> required, so I need to understand exactly what is required.
>
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > Problem description
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > In the kernel every 'struct device_node' is refcounted so the OF core
> > > knows when to free it. There are of course get/put imbalance bugs
> > > around, but these are "just" bugs that need to be fixed as they are
> > > found.
> > >
> > > On the other hand, there is no refcounting for 'struct property'. Yet
> > > some of the internal kernel APIs to access properties, e.g.
> > > of_property_read_string(), return either a 'struct property' pointer =
or
> > > a copy of the 'char *value' field. This is not a bug, it is an API
> > > design flaw: any user (e.g. any OF driver) can take a pointer to
> > > property data that was allocated and should be deallocated by the OF
> > > core, but the OF core has no idea of when that pointer will stop bein=
g
> > > used.
> > >
> > > Now, when loading a DT overlay there are three possible cases:
> > >
> > >  1. both the property and the containing node are in the base tree
> > >  2. both the property and the containing node are in the same overlay
> > >  3. the property is in an overlay and the containing node is either
> > >     in the base tree or in a previously-loaded overlay
> > >
> > > Cases 1 and 2 are not problematic. In case 1 the data allocated for t=
he
> > > properties is never removed. In case 2 the properties are removed whe=
n
> > > removing the parent node, which gets removed when removing the overla=
y
> > > thanks to 'struct device_node' refcounting, based on the assumption
> > > that the property lifetime is a subset of the parent node lifetime. T=
he
> > > problem exists in case 3. Properties in case 3 are usually a small pa=
rt
> > > of all the properties but there can be some (and there are some in th=
e
> > > product we are working on), and that's what needs to be addressed.
> >
> > I'd like to better understand what are the cases where you need to
> > change/add properties in a node (other than "status"). I'm not
> > entirely convinced we should even allow that.
>
> Glad to provide details! There are 3 cases, all from the hotplug
> connector work we have been discussing [0]:
>
>  1. NVMEM cell
>  2. Display pipeline remote-endpoint
>  3. Labels in the overlay
>
> 1) NVMEM cells: the removable add-on has a model ID in an EEPROM, so
> the overlay adds nvmem-cells and nvmem-cell-names properties under the
> connector node (which is in the base DT). From the  I got your
> skepticism in [0] but not exactly how differently you would address
> this.
>
> This generates warnings for:
>   /addon-connector/nvmem-cells
>   /addon-connector/nvmem-cell-names
>
> How to avoid this: I see no obvious/easy clean solution given the NVMEM
> cell bindings. I can only think about workarounds bypassing the NVMEM
> APIs and open-coded device tree parsing in the connector driver,
> reinventing what the NVMEM subsystem does.
>
> 2) We have a video bridge on the removable add-on, which on hotplug
> will attach to the bridge on the fixed side. So we have:
>
> Fixed side (excerpt):
>
> / {
>   addon-connector {
>     ports {
>       port@0 {...} // connected to previous bridge, on fixed side
>       port@1 {
>         hotplug_bridge_source: endpoint {               <--- node
>           // remote-endpoint to be added by overlay
>         };
>       };
>     };
>   };
> };
>
> Removable add-on side (excerpt):
>
> &hotplug_bridge_source {
>   // Fill in the missing link from the fixed side to us
>   remote-endpoint =3D <&sn65dsi84_from_bridge>;           <--- property
> };
>
> &i2c5 {
>   // Bridge on the removable add-on
>   dsi-lvds-bridge@2c {
>     compatible =3D "ti,sn65dsi84";
>     reg =3D <0x2c>;
>     ports {
>       port@0 {
>         sn65dsi84_from_bridge: endpoint {
>           // Link to the DRM device on the fixed side
>           remote-endpoint =3D <&hotplug_bridge_source>;
>           data-lanes =3D <1 2 3 4>;
>         };
>       };
>     };
>   };
> };
>
> This generates a warning for:
>   /addon-connector/ports/port@1/endpoint/remote-endpoint
>
> How to avoid this: as I was writing this e-mail I realized we might
> be able to move the entire /addon-connector/ports/port@1 node to the
> overlay. I did a quick test, seems to be working, but I have to ensure
> about the consequences on the DRM side.
>
> 3) There are labels in overlays, even ones that are only used
> internally within the same overlay.
>
> Example:
>
> &{/} {
>         addon_sys_pwr: addon-sys-pwr {            <--- label
>                 compatible =3D "regulator-fixed";
>         };
>
>         addon-3v3-sys {
>                 compatible =3D "regulator-fixed";
>                 vin-supply =3D <&addon_sys_pwr>;    <--- phandle
>         };
> };
>
> Note the label is only used "internally" to the overlay in this example,
> but dtc doesn't know so it will add a property in /__symbols__ for each
> label.
>
> Each label results in warnings for properties:
>   /__symbols__/addon_sys_pwr
>   /__symbols__/addon_3v3_sys
>
> This applies to any other labels, not only regulators.
>
> How to avoid this?
>
> If cases 1 and 2 can be solved, it should be possible to build the
> overlays without -@, so no properties added to //__symbols__. Would be
> great!
>
> Otherwise: these are really DT core internals, no code outside
> drivers/of/ is supposed to fiddle with them, and we can assume the DT
> core to be safe. So we may not add these properties to the deadprops
> list, and thus avoid warning about them.
>
> I look forward to reading your thoughts about these 3 cases, especially
> the NVMEM one.
>
> [0]
> https://lore.kernel.org/all/20240510-hotplug-drm-bridge-v2-1-ec32f2c66d56=
@bootlin.com/
>
> > > ~~~~~~~~~~~~~~~~~~~~~~~
> > > Accessor classification
> > > ~~~~~~~~~~~~~~~~~~~~~~~
> > >
> > > We examined and classified the various APIs that allow accessing the =
OF
> > > properties, which we called accessors, and counted their call sites.
> > >
> > > There are three kinds of property accessor functions in the OF APIs
> > > that need to be fixed:
> > >
> > >  1. classic accessors
> > >  2. for_each loop macros and supporting functions
> > >  3. OF reconfig notifiers
> > >
> > > -----------------
> > > Classic accessors
> > > -----------------
> > >
> > > Classic accessors are those that return some property value. Examples
> > > include:
> > >
> > >   of_find_property()
> > >   of_property_read_string()
> > >   of_get_property()
> > >   of_property_read_string_index()
> >
> > Eliminating/limiting of_(find|get)_property() has been on my list for
> > some time. I've been chipping away at it slowly.
> >
> > of_property_read_string() is the "new" typed API, but yes, that's a pro=
blem.
> >
> >
> > > Classic accessors have lots of call sites: we counted about 1900. Man=
y
> > > are in drivers and will need to be addressed individually, one by one=
.
> > > So the plan is to add new "safe" accessors and progressively convert
> > > drivers and other call sites to use them, to eventually remove the
> > > current unsafe accessors.
> >
> > 1200 of these are of_(get|find)_property. Of that 500 are in arch and
> > almost all powerpc and sparc which we can probably exclude from all
> > this. That leaves drivers/ and sound/ mostly. A good percentage of
> > those looks like powerpc and sparc drivers. 70 are internal to
> > drivers/of/.
> >
> > Of the remaining ones, which ones could ever be in an overlay? I don't
> > really see much: gpio-fan, pwm backlight, a USB hub, etc.
>
> As I read it, looks like having zero "leak" warnings would be enough for
> having a driver such as the connector driver [0] merged. Is it the case?
>
> As above, we thought about a plan to entirely eliminate all APIs
> returning property pointers, but reducing the effort would not be
> unwelcome.
>
> > > One supporting strategy in that direction is making 'struct property'
> > > opaque, which would ensure its fields just cannot be accessed directl=
y.
> > > I attempted it and the amount of code that gets broken and needs to b=
e
> > > fixed is "manageable".
> > >
> > > An even stronger strategy is to move struct property completely outsi=
de
> > > in-kernel public include files (i.e. from include/linux/of.h to
> > > drivers/of/of_private.h) so even struct property pointer cannot exist
> > > anymore outside of the OF core. However this is quite extreme and ver=
y
> > > hard to apply (see the section about for_each loops).
> >
> > Making that and device_node opaque have also been on my todo. I
> > started some work on device_node, but didn't get too far.
>
> I agree it would be good, at least in principle, but device_node is
> definitely out of the scope of our plans.
>
> > > ---------------------------------------------
> > > for_each loop macros and supporting functions
> > > ---------------------------------------------
> > >
> > > Fixing the for_each iterators (about 140 call sites) is hard because
> > > they use 'struct property' pointers "internally", but being macros th=
e
> > > iterarot is exposed to code using those macros. So we propose a
> > > mitigation strategy that is more approachable and a removal strategy.
> > >
> > > The mitigation strategy is based on the declaring variables in the fo=
r
> > > loop init clause, as allowed since the kernel has moved to C gnu11.
> > > This would allow replacing typical code like:
> > >
> > >   struct device_node *node =3D <...>;
> > >   struct property *prop;
> > >   const __be32 *cur;
> > >   u32 rate;
> > >
> > >   of_property_for_each_u32(node, "my-property", prop, cur, rate) {
> > >
> > > with code like:
> > >
> > >   struct device_node *node =3D <...>;
> > >   u32 rate;
> > >
> > >   of_property_for_each_u32(node, "my-property", rate) {
> > >
> > > This is only a mitigation strategy because it would not strictly forb=
id
> > > access to the struct property and the __be32 variables. But it would
> > > make it less easy and much more visible to code reviewers and possibl=
y
> > > checkpatch, and as such it would make it hard to add my mistake. It
> > > also makes code simpler and more readable so it is an overall
> > > improvement as well.
> >
> > That would be a nice clean-up.
> >
> > For for_each_property_of_node(), I think we can eliminate it. There's
> > only a few cases, and most are looking for property names with a
> > specific prefix or suffix. There's several copies just for
> > regulators...
> >
> > >
> > > This is simple to implement and at first glance about half of the cal=
l
> > > sites can benefit. For those which cannot, an ad-hoc solution must be
> > > devised, possibly based on a full array copy as a last resort.
> > >
> > > The removal strategy involves a total removal of these looping macros=
,
> > > in lack of a way to implement them without giving access to the
> > > property and iterator pointers. Removal of these APIs would involve
> > > replacing them with specific accessors that internally loop and do wh=
at
> > > is needed (for common cases) or return a full copy for other cases.
> > > Passing a callback for the looping function to operate on members is
> > > also potentially doable but cumbersome for callers.
> > >
> > > Instead of the removal strategy I think there might be better tools,
> > > but I still haven't done a real evaluations so far.
> > >
> > > Note that if struct property were made internal, the removal strategy
> > > would become unavoidable.
> > >
> > > ---------------------
> > > OF reconfig notifiers
> > > ---------------------
> > >
> > > Reconfig notifiers are callbacks that can be enabled in order to be
> > > notified of changes to the device tree. The APIs themselves are not
> > > leaking internal pointers, but the notifier callbacks are passed a
> > > 'struct of_reconfig_data *' parameter which contains pointers to the
> > > old and new struct property pointers.
> > >
> > > If struct property were opaque this would not expose pointers to
> > > property name/len/value. Still the struct property pointer would be
> > > exposed. So we propose to make the entire struct of_reconfig_data
> > > opaque.
> > >
> > > The drawback is that several new (trivial) accessors would be needed =
to
> > > get the data from such an opaque structure. However call sites of
> > > notifiers are limited (about 10), some don=E2=80=99t even access prop=
erties at
> > > all and others appear to use them carefully, so a fix would be
> > > relatively simple to do.
> >
> > I need to study this more, but a notifier is never a great design so
> > maybe we can come up with something better.
>
> Do you have specific ideas in mind? I'm very interested in knowing
> alternative options.

Like I said, need to study it more... Perhaps just remove notifying on
properties. I think properties changing at any point in time is
difficult to support and we just shouldn't support that other than a
few exceptions like "status". Or we could have a "node changed"
notifier and then it's the client's problem to figure out what
property changed.

> > > ~~~~~~~~~~~~~~~
> > > Transition plan
> > > ~~~~~~~~~~~~~~~
> > >
> > > Transitioning to the new accessors is not going to happen quickly giv=
en
> > > the amount of call sites, so we devised a strategy to incrementally
> > > approach it while avoiding introducing new calls to the old APIs.
> > >
> > > The transition plan is based on adding a Kconfig symbol (a tentative
> > > name is CONFIG_EXPORT_UNSAFE_OF_ACCESSORS) meaning =E2=80=9Cexport ol=
d OF
> > > accessor functions returning pointers to firmware data=E2=80=9D and d=
efaulting
> > > to =E2=80=98y=E2=80=99 to avoid breaking current usages. When this is=
 set to =E2=80=98n=E2=80=99:
> > >
> > >  - The old accessors returning pointers to struct property values are
> > >    not built, or at least not exported outside the OF core
> > >  - So any defconfig with at least one driver using the old accessors
> > >    would just not build, which allows to easily find out what needs t=
o
> > >    be updated if one wants to remove overlays in their specific
> > >    configuration, or to disable unneeded drivers that are not yet
> > >    updated
> > >  - The property leaks under discussion are not possible anymore
> > >  - The deadprops list and the warning are not built
> > >  - Note: we need to ensure automated test bots won=E2=80=99t set this=
 setting
> > >    to =E2=80=98n=E2=80=99 or they will fail
> > >
> > > Any code using DT overlays, including the connector driver proposed i=
n
> > > [2], can depend on CONFIG_EXPORT_UNSAFE_OF_ACCESSORS=3Dn, to ensure t=
he
> > > leaking APIs are never called when runtime-loadable overlays are in u=
se.
> > >
> > > Preventing new usages of old accessors will be important. Tools to
> > > achieve that:
> > >
> > >  * Extend checkpatch to report an error on their usage
> > >  * Add a 'K:' entry to MAINTAINERS so that patches trying to use them
> > >    will be reported (to me at least)
> >
> > That would be good, but I have doubts on it preventing new users. Not
> > that we shouldn't do it, but if I had a dollar for everytime I said
> > run get_maintainers.pl or checkpatch.pl... I have wanted to document
> > various functions which are "don't add new users unless you really
> > have to". Things like of_iomap() or of_irq_*.
>
> I think doing our best is the best we can do in this respect. :)
>
> > > Once all call sites are updated to the new API, the old API can be
> > > removed entirely along with the deadprops list and the
> > > CONFIG_EXPORT_UNSAFE_OF_ACCESSORS Kconfig symbol.
> >
> > I don't like the kconfig symbol even if it is temporary. How does it
> > get configured for a multi-platform kernel?
>
> First of all: this kconfig symbol is useful only if the goal is to
> remove all property-leaking APIs.
>
> The idea is to use it as a guard: if a defconfig builds with it set to
> 'n', then all the code enabled in that defconfig is not using any
> "unsafe" accessor. Meaning: we haven't removed all accessors from the
> whole kernel, but from the subset of the kernel that this defconfig is
> building.
>
> For multi-platform kernels it is not much relevant in the short term.
> If/when at some point we will be able to set it to 'n' in one of them
> (e.g. arch/arm64/configs/defconfig) that would mean a large percentage
> of call sites have been removed, and (even more important) _no_ call
> sites will be added anymore or the defconfiig will fail immediately.
>
> And I think it should be a requirement for any driver loading/unloading
> overlays, so that one cannot even load an overlay without fixing all
> the call sites. I think this is the most relevant usefulness in the
> short term: either you call unsafe accessors or you load overlays, not
> both.

Sure, but that can be runtime. If you load overlays, then you'll get
warnings for calling unsafe accessors on the nodes associated with the
overlay.

Now if we want a debug kconfig option to warn on all cases, that would be f=
ine.

> > > =3D=3D=3D=3D=3D=3D=3D
> > > Roadmap
> > > =3D=3D=3D=3D=3D=3D=3D
> > >
> > > We plan to address this in various steps, in order to allow an easier
> > > review process and to have the various changes tested progressively.
> > >
> > > The main steps in our roadmap are:
> > >
> > >  1. Make struct property opaque and fix code that gets broken
> > >  2. Main API transition (class 1):
> > >     - Add new safe accessors
> > >     - Implement CONFIG_EXPORT_UNSAFE_OF_ACCESSORS to hide leaking
> > >       accessors
> > >     - Document the above
> > >     - OF implementation
> > >     - fwnode wrapper (for ACPI+SWNODE)
> > >     - rwsem/RCU synchronisation mechanism
> > >     - convert a few drivers
> > >  3. Prevent new patches using old accessors from being merged
> > >     (checkpatch, MAINTAINERS...)
> > >  4. Convert a significant number of drivers (enough to support a
> > >     complex SoC)
> >
> > But why? Pretty much all of the SoC support is fixed. We only need to
> > avoid leaking pointers for the parts which can be dynamic. We know
> > which nodes and properties are dynamic already. Of course there's the
> > LAN96xx the SoC is the PCI device case, but that's a bit special in
> > that we would be removing everything.
> >
> > Can't we just WARN on using the old accessors on nodes or properties
> > which are dynamic?
>
> As above, that's because the plan is (was?) to eventually remove all
> the leaking accessors.
>
> > >  5. for_each loops (class 2) mitigation strategy
> > >  6. Make struct of_reconfig_data opaque (class 3)
> > >  7. for_each loops (class 2) full removal strategy
> > >
> > > We think the necessity of the last two step is subject to discussion,
> > > while all the previous ones are required.
> > >
> > > Note there is no "convert all call sites" in the plan. The amount of
> > > drivers alone is huge, and converting all of them would not be doable
> > > entirely by us both in terms of amount of work and for lack of hardwa=
re
> > > to test the changes.
> >
> > That would only be necessary if we allow any change everywhere in a DT
> > on every system. IOW, if we accepted the userspace configfs overlay
> > applying patchset. If things are constrained to specific systems and
> > specific parts of a DT (e.g. under a connector node), then it is a lot
> > fewer pieces to fix. If powerpc is excluded for example, that alone
> > eliminates a bunch of code and drivers to worry about.
>
> Bottom line, I think the takeaway is that in your opinion removing the
> unsafe property accessors is not a requirement for accepting a driver
> that loads/unloads an overlay. Only having zero warnings for the
> specific overlay is a requirement. Correct?

Right, assuming unsafe property accessors warn or we can deem it safe
in some other way. For example, we've had fixup overlays which fixed
old bindings to new ones in tree. Those were safe as they are never
removed and are applied before the affected driver probed.

> For the connector we are planning to load the overlays from the
> filesystem (not built into the kernel). Would the above still be
> correct in this case?

Yes. The FPGA mgr stuff was supposed to do exactly this. Load the
overlay with the firmware API. I'm not sure what happened there.

Rob


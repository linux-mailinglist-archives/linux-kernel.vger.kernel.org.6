Return-Path: <linux-kernel+bounces-377613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D34E9AC140
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9568EB24DD3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF85A155757;
	Wed, 23 Oct 2024 08:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="lvpbz4kt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="neFiLzpd"
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EEC1C2BD;
	Wed, 23 Oct 2024 08:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729671349; cv=none; b=eRK7JQ4EwIZ6Oel03CX9RQCqTnfMtjXsk885Zh+NUoZPYfGJVburoOXZG1JQ5dzkFBFvbu5VxjISXjgrw7xeONkh8AKRb9hPmddO5XspQFSO+d/ak9akg+r7TTBgaXJ7nkkScMg+5ntm/08pi0PorUShOPyy4fF8ms06skeRVUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729671349; c=relaxed/simple;
	bh=keqyoGxTGCop3S+33pegqN9kzIXjLkGFnHSGgAKVVtg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=U28hzXSokPG2r1WEBGOFBVVpuYXurCmwvXNZaC4AUgxhoMu09BaTu8i+zUbVDXnSBALtVyd97rwOLU6AdOZoaLDwyuV9YhWz2pUEQqpBCXVSwDOqhTSPlTppAh8sl3mk05AwZxUmD9cbqwNymWDW1DYFjdPKFe1neiivTzJKxNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=lvpbz4kt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=neFiLzpd; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id E4FB6138059A;
	Wed, 23 Oct 2024 04:15:45 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-08.internal (MEProxy); Wed, 23 Oct 2024 04:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1729671345;
	 x=1729757745; bh=U8dyB79jhYfmUMSHL6RcsVZ3tGE5j/VEcT9woIlZiHI=; b=
	lvpbz4kt72MNuPaQHlI2MdlwWJHL2Y88q+/8q/AMGP6eJK7iOB/I+y+46zYdWU10
	mXkMqV+MgWuyX6R52o/pluSh6dp92xWOw2frwOQ0iiHFgWWR5r5Aey3yVZ6z/TaC
	lPUpvfBQ27TIKcHrgtJAHLgtbS6ObnkgidJr92VLhGaLePFdiX6XsrVCVw04KFlq
	8tD2o3gzma6131HxcUpsuZcSzbRoKQlEY5YWX6hBdEqbDzpsMd9z3vXdEgbPbFJk
	mBUKBdXvFCEnaoNh1FbfM9fuGkzvuxyl6QHaBT50b+9rdvkuKemZHrrv1S/e4tOX
	6+2T+3Md80ZTOIkagHOtOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729671345; x=
	1729757745; bh=U8dyB79jhYfmUMSHL6RcsVZ3tGE5j/VEcT9woIlZiHI=; b=n
	eFiLzpdtZzsR0XZcLMTK06KLlzc70IN/EG593K6fRCSaxE1+gSP7XK6w9NxHvcwO
	WGTXVznZV7sX67njSODn7QmP+ysvsllR1TMbNI7K30AsRhr3X22M+cV1yEzJiNzL
	Qk44LC6jsWDPLF9v+kOcwKEnhjbhb43LXnJbIkTl+efaGKBP//aH+YVuKjhRU33W
	1tOv6TDN46lYYTOPV8EREeHenomOxTl+K8Qr8TZlHX9xNfrUoA2E9aNQZil4i7/x
	2xLfNn50GB6DwBn5yanFXMpXIzIhXl9ZwSoI2g0gyBtz7zv0lmwK0u1mx+BMlIlk
	NlTqPgYZiF05YGiWwIcSg==
X-ME-Sender: <xms:sbAYZ6yPB7AMa-r4QGwLET1XCrPY9D0qCQy8affNT6UAl4BiFjIpIQ>
    <xme:sbAYZ2TQ0qBDM7vwSiXFHC_0Ic0naRVvdDqlf_r-dAmUu04ATUZFWbAk9Ab34rt7d
    CVVEv8ZkbpuVe7CuFY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeijecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffrtefo
    kffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsuc
    dlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfh
    rhhomhepfdfnuhhkvgculfhonhgvshdfuceolhhukhgvsehljhhonhgvshdruggvvheqne
    cuggftrfgrthhtvghrnheptedvheeiuefftedutdehteelffejueettdejudduhfefieev
    vdehgeektdetkedvnecuffhomhgrihhnpegrshhushdrtghomhdpphhhohhrohhnihigrd
    gtohhmpdhgihhthhhusgdrtghomhdpghhithhlrggsrdgtohhmpdifmhhipghsphgvtgdr
    mhgunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplh
    hukhgvsehljhhonhgvshdruggvvhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheptghorhgvnhhtihhnrdgthhgrrhihsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepfigprghrmhhinhesghhmgidruggvpdhrtghpthhtoheptggrshgv
    hidrghdrsghofihmrghnsehinhhtvghlrdgtohhmpdhrtghpthhtohepihhlphhordhjrg
    hrvhhinhgvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehsrhhinhhi
    vhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpth
    htohepmhhitghhrggvlhesphhhohhrohhnihigrdgtohhmpdhrtghpthhtohephhguvghg
    ohgvuggvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehplhgrthhfohhrmhdqughr
    ihhvvghrqdigkeeisehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:sbAYZ8XqjKz6V9dpN2p7rLlIqnUfZd_biYahk_N2dyKNOyos1oxEPA>
    <xmx:sbAYZwhgbJuPM9_TIUo7A5CJ-QxyjUCxGk-1qd9LnUQuQIGVcGN41w>
    <xmx:sbAYZ8DXDz-5xVREf1rfn64hBvXZo1934mygeT7WhDXrOvz6c-1a1Q>
    <xmx:sbAYZxL5e_tmmnMnk99uyHrKPPSBi-FBoBtg-9Zm3ChfC06ho4cNCg>
    <xmx:sbAYZ6A74Vps67kdBfS1wdW784kPR3y0gFDy2_tSPn08PX9T9mDbiqFT>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7DA313360079; Wed, 23 Oct 2024 04:15:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 23 Oct 2024 10:15:24 +0200
From: "Luke Jones" <luke@ljones.dev>
To: "Armin Wolf" <W_Armin@gmx.de>,
 "Srinivas Pandruvada" <srinivas.pandruvada@linux.intel.com>,
 corentin.chary@gmail.com, "Hans de Goede" <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Michael Larabel" <Michael@phoronix.com>,
 "Casey Bowman" <casey.g.bowman@intel.com>
Message-Id: <e5016c07-05e1-4b05-9f1a-bf664135dbdf@app.fastmail.com>
In-Reply-To: <911ce141-8f20-48fb-bc43-e6d4262dbc81@gmx.de>
References: <20241020065051.1724435-1-srinivas.pandruvada@linux.intel.com>
 <911ce141-8f20-48fb-bc43-e6d4262dbc81@gmx.de>
Subject: Re: [PATCH] platform/x86: asus-wmi: Support setting AIPT modes
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, 20 Oct 2024, at 9:05 PM, Armin Wolf wrote:
> Am 20.10.24 um 08:50 schrieb Srinivas Pandruvada:
>
>> Some recent Asus laptops are supporting ASUS Intelligent Performance
>> Technology (AIPT). This solution allows users to have maximized CPU
>> performance in models with a chassis providing more thermal head room.
>> Refer to [1].
>>
>> There are major performance issues when Linux is installed on these
>> laptops compared to Windows install. One such report is published for
>> Graphics benchmarks on Asus ASUS Zenbook S 14 with Lunar Lake
>> processors [2].
>>
>> By default, these laptops are booting in "Whisper Mode" till OS power
>> management or tools change this to other AIPT mode. This "Whisper" mo=
de
>> calls to set lower maximum and minimum RAPL (Running Average Power Li=
mit)
>> via thermal tables. On Linux this leads to lower performance even when
>> platform power profile is "balanced". This "Whisper" mode should
>> correspond to "quiet" mode.
>>
>> So, when AIPT is present change the default mode to "Standard" during
>> boot. Map the three platform power profile modes as follows:
>>
>> Power Profile Mode      AIPT mode
>> -----------------------------------
>> quiet			Whisper
>> balanced		Standard
>> performance		Performance
>> ------------------------------------
>>
>> Here AIPT mode can be detected by checking presese of "FANL" method u=
nder
>> PNP HID "PNP0C14" and UID "ATK". If AIPT mode is present, this takes
>> precedence over the existing VIVO thermal policy. These modes are set
>> using "FANL" method.
>>
>> Although this =E2=80=9CFANL=E2=80=9D method is not used in the Asus W=
MI driver, users
>> have used this method from user space [3] to set AIPT modes. Used this
>> as a reference.
>>
>> Link: https://www.asus.com/content/laptop-asus-intelligent-performanc=
e-technology-aipt/ # [1]
>> Reported-by: Michael Larabel <Michael@phoronix.com>
>> Closes: https://www.phoronix.com/review/lunar-lake-xe2/5 # [2]
>> Link: https://github.com/dominiksalvet/asus-fan-control/issues/151 # =
[3]
>> Tested-by: Casey Bowman <casey.g.bowman@intel.com>
>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.c=
om>
>> ---
>>   drivers/platform/x86/asus-wmi.c | 93 ++++++++++++++++++++++++++++++=
+--
>>   1 file changed, 89 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/a=
sus-wmi.c
>> index 7a48220b4f5a..06689d0f98c7 100644
>> --- a/drivers/platform/x86/asus-wmi.c
>> +++ b/drivers/platform/x86/asus-wmi.c
>> @@ -100,6 +100,11 @@ module_param(fnlock_default, bool, 0444);
>>   #define ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO	1
>>   #define ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO	2
>>
>> +#define AIPT_STANDARD				0
>> +#define AIPT_WHISPER				1
>> +#define AIPT_PERFORMANCE			2
>> +#define AIPT_FULL_SPEED				3
>> +
>>   #define PLATFORM_PROFILE_MAX 2
>>
>>   #define USB_INTEL_XUSB2PR		0xD0
>> @@ -333,6 +338,9 @@ struct asus_wmi {
>>   	struct asus_wmi_debug debug;
>>
>>   	struct asus_wmi_driver *driver;
>> +	acpi_handle acpi_mgmt_handle;
>> +	int asus_aipt_mode;
>> +	bool asus_aipt_present;
>>   };
>>
>>   /* WMI ************************************************************=
************/
>> @@ -3804,6 +3812,19 @@ static ssize_t throttle_thermal_policy_store(s=
truct device *dev,
>>   static DEVICE_ATTR_RW(throttle_thermal_policy);
>>
>>   /* Platform profile ***********************************************=
************/
>> +static int asus_wmi_write_aipt_mode(struct asus_wmi *asus, int aipt_=
mode)
>> +{
>> +	int status;
>> +
>> +	status =3D acpi_execute_simple_method(asus->acpi_mgmt_handle, "FANL=
", aipt_mode);
>> +	if (ACPI_FAILURE(status)) {
>> +		acpi_handle_info(asus->acpi_mgmt_handle, "FANL execute failed\n");
>> +		return -EIO;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   static int asus_wmi_platform_profile_to_vivo(struct asus_wmi *asus,=
 int mode)
>>   {
>>   	bool vivo;
>> @@ -3844,6 +3865,26 @@ static int asus_wmi_platform_profile_mode_from=
_vivo(struct asus_wmi *asus, int m
>>   	return mode;
>>   }
>>
>> +static int asus_wmi_aipt_platform_profile_get(struct asus_wmi *asus,
>> +					      enum platform_profile_option *profile)
>> +{
>> +	switch (asus->asus_aipt_mode) {
>> +	case AIPT_STANDARD:
>> +		*profile =3D PLATFORM_PROFILE_BALANCED;
>> +		break;
>> +	case AIPT_PERFORMANCE:
>> +		*profile =3D PLATFORM_PROFILE_PERFORMANCE;
>> +		break;
>> +	case AIPT_WHISPER:
>> +		*profile =3D PLATFORM_PROFILE_QUIET;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   static int asus_wmi_platform_profile_get(struct platform_profile_ha=
ndler *pprof,
>>   					enum platform_profile_option *profile)
>>   {
>> @@ -3851,6 +3892,10 @@ static int asus_wmi_platform_profile_get(struc=
t platform_profile_handler *pprof,
>>   	int tp;
>>
>>   	asus =3D container_of(pprof, struct asus_wmi, platform_profile_han=
dler);
>> +
>> +	if (asus->asus_aipt_present)
>> +		return asus_wmi_aipt_platform_profile_get(asus, profile);
>> +
>>   	tp =3D asus->throttle_thermal_policy_mode;
>>
>>   	switch (asus_wmi_platform_profile_mode_from_vivo(asus, tp)) {
>> @@ -3874,26 +3919,42 @@ static int asus_wmi_platform_profile_set(stru=
ct platform_profile_handler *pprof,
>>   					enum platform_profile_option profile)
>>   {
>>   	struct asus_wmi *asus;
>> -	int tp;
>> +	int ret =3D 0, tp, aipt_mode;
>>
>>   	asus =3D container_of(pprof, struct asus_wmi, platform_profile_han=
dler);
>>
>>   	switch (profile) {
>>   	case PLATFORM_PROFILE_PERFORMANCE:
>>   		tp =3D ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST;
>> +		aipt_mode =3D AIPT_PERFORMANCE;
>>   		break;
>>   	case PLATFORM_PROFILE_BALANCED:
>>   		tp =3D ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
>> +		aipt_mode =3D AIPT_STANDARD;
>>   		break;
>>   	case PLATFORM_PROFILE_QUIET:
>>   		tp =3D ASUS_THROTTLE_THERMAL_POLICY_SILENT;
>> +		aipt_mode =3D AIPT_WHISPER;
>>   		break;
>>   	default:
>>   		return -EOPNOTSUPP;
>>   	}
>>
>> -	asus->throttle_thermal_policy_mode =3D asus_wmi_platform_profile_to=
_vivo(asus, tp);
>> -	return throttle_thermal_policy_write(asus);
>> +	if (asus->asus_aipt_present) {
>> +		ret =3D asus_wmi_write_aipt_mode(asus, aipt_mode);
>> +		if (!ret) {
>> +			asus->asus_aipt_mode =3D aipt_mode;
>> +			goto skip_vivo;
>> +		}
>> +	}
>> +
>> +	if (asus->throttle_thermal_policy_dev) {
>> +		asus->throttle_thermal_policy_mode =3D asus_wmi_platform_profile_t=
o_vivo(asus, tp);
>> +		ret =3D throttle_thermal_policy_write(asus);
>> +	}
>> +
>> +skip_vivo:
>> +	return ret;
>>   }
>>
>>   static int platform_profile_setup(struct asus_wmi *asus)
>> @@ -3905,7 +3966,7 @@ static int platform_profile_setup(struct asus_w=
mi *asus)
>>   	 * Not an error if a component platform_profile relies on is unava=
ilable
>>   	 * so early return, skipping the setup of platform_profile.
>>   	 */
>> -	if (!asus->throttle_thermal_policy_dev)
>> +	if (!asus->throttle_thermal_policy_dev && !asus->asus_aipt_present)
>>   		return 0;
>>
>>   	dev_info(dev, "Using throttle_thermal_policy for platform_profile =
support\n");
>> @@ -4538,6 +4599,7 @@ static int asus_wmi_sysfs_init(struct platform_=
device *device)
>>   static int asus_wmi_platform_init(struct asus_wmi *asus)
>>   {
>>   	struct device *dev =3D &asus->platform_device->dev;
>> +	struct acpi_device *adev;
>>   	char *wmi_uid;
>>   	int rv;
>>
>> @@ -4593,6 +4655,29 @@ static int asus_wmi_platform_init(struct asus_=
wmi *asus)
>>   		asus_wmi_set_devstate(ASUS_WMI_DEVID_CWAP,
>>   				      asus->driver->quirks->wapf, NULL);
>>
>> +	/*
>> +	 * Check presence of Intelligent Performance Technology (AIPT).
>> +	 * If present store acpi handle and set asus_aipt_present to true.
>> +	 */
>> +	adev =3D acpi_dev_get_first_match_dev("PNP0C14", "ATK", -1);
>
> Is there really no way of changing the AIPT mode through the WMI inter=
face?
> I would prefer using the WMI interface if available, since the firmwar=
e might
> assume that FANL is only called through the WMI interface.
>
> Do you have a acpidump from a affected device?
>
> Thanks,
> Armin Wolf
>
>> +	if (adev) {
>> +		acpi_handle handle =3D acpi_device_handle(adev);
>> +
>> +		acpi_dev_put(adev);
>> +
>> +		if (!acpi_has_method(handle, "FANL"))
>> +			return 0;

Quite a few laptops have this method available, but may not actually do =
anything. Such as the following:

FX517ZM-dsdt.dsl
92885:        Method (FANL, 1, Serialized)
92886-        {
92887-            Return (One)
92888-        }

While this one does (zenbook duo):

UX8402.dsl
88837:                Method (FANL, 1, Serialized)
88838-                {
88839-                    ODV0 =3D Arg0
88840-                    If ((^^PC00.PEG1.PXP._STA =3D=3D One))
--
89041:                    Return (FANL (IIA0))
89042-                }
89043-
89044-                If ((Local0 =3D=3D 0x4647574D))
--
89604:                        FANL (IIA1)
89605-                        Return (One)
89606-                    }
89607-

I've discovered the majority of WMI methods, you can see them here: http=
s://gitlab.com/asus-linux/reverse-engineering/-/blob/master/WMI_SPEC.md?=
ref_type=3Dheads

There is a "whisper mode" WMI  method, but I've not done much around it.

I also have a large collection of DSL if that is helpful https://gitlab.=
com/asus-linux/reverse-engineering/-/tree/master/dsl-collection?ref_type=
=3Dheads

It seems that because I have access only to the ROG dlls at this time I =
may have missed the WMI method: 0x00110019, this is likely what you need=
 as it gets FANF, and sets FANL

=E2=9D=AF rg 0x00110019 -B3 -A3 UX8402.dsl=20
89281-                        Return (0x00010000)
89282-                    }
89283-
89284:                    If ((IIA0 =3D=3D 0x00110019))
89285-                    {
89286-                        Local0 =3D FANF /* \_SB_.FANF */
89287-                        Local1 =3D 0x00070000
--
89599-                        Return (One)
89600-                    }
89601-
89602:                    If ((IIA0 =3D=3D 0x00110019))
89603-                    {
89604-                        FANL (IIA1)
89605-                        Return (One)

Hopefully this is helpful,

Regards,
Luke.

P.S: If any info is discovered that I am lacking in my repo it would be =
highly appreciated if a PR added it.

>> +		asus->acpi_mgmt_handle =3D handle;
>> +		asus->asus_aipt_present =3D true;
>> +		dev_info(dev, "ASUS Intelligent Performance Technology (AIPT) is p=
resent\n");
>> +		/*
>> +		 * Set the mode corresponding to default Linux platform power
>> +		 * profile Balanced
>> +		 */
>> +		asus_wmi_write_aipt_mode(asus, AIPT_STANDARD);
>> +	}
>> +
>>   	return 0;
>>   }
>>


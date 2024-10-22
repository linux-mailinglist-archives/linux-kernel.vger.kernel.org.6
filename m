Return-Path: <linux-kernel+bounces-376865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 074FE9AB6D6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B77F12844F6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBBF1CDFC3;
	Tue, 22 Oct 2024 19:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="LqgJCOLg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="emMiLoka"
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3E31494CE;
	Tue, 22 Oct 2024 19:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729625442; cv=none; b=b/cDD9QikfxsyQfbrgzL2lM4LJPB64fmGV3WQEX1BYANT8sRZp9MlgdfYcEDhbdk4FtyIx3JzhC3YedoKIO3BD/woxhAgQGz5ZWX/bEBha3P8lYSgpYswY7RCvHNxpRumPQRnBC9Mv5u6p6Wt3lRmtyykjpVKtxNMhaiO+zw7ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729625442; c=relaxed/simple;
	bh=mu9NEAF4GH7X9+Dq/UFSihjdnU5ET9r0rkngSkX0RYg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=aJRNATTa4rLUVu+FSzUjkJ8g0jcxgUr7a5vQmltKMvyrTSwJmz9K5TcEA/Ns34XePUdlUqkc7Bzc+KSllePmap9r1odm2RpgswLLnfl+T7HzWAO9MBmkU//lQYNtbXxNXrW/frGW8amxMTo0y3pKvtF5QmWdlH2SljDT1vW9IQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=LqgJCOLg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=emMiLoka; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B2A6525400E5;
	Tue, 22 Oct 2024 15:30:39 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-02.internal (MEProxy); Tue, 22 Oct 2024 15:30:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1729625439;
	 x=1729711839; bh=Zye2GdwIvJkPNjXAQSWrqToem6eNUlfkvWe1pGHqEu0=; b=
	LqgJCOLgP4y8RhQoJRminjFDcHK8ReRoXlHTXT+MWAL6gh4aIzFH2RSQUtwjKvF3
	bopChy57i1uu8GIKKGvdHjyGNv3uRY3XrN+lQ7Z+UduaTVbmClIqi7Sx8ly9bd3C
	yDwHw2jyQxaN35rbP+WtmOcY1vGyCSnBzN4XaZTAlZ2+51KmBsB8oCg/WhKYsUCA
	REyVctWlRp7LtlKOmohkDn0EqLjaDpLcRwQjt8CQSvaR/gg4j9IaOSC8b/MoRRvT
	JcqjjMqLw6OnLGRkshjMmYceQPQGdc/4emsW9sSUpykiyUBSXnjtjqarJHTaV8yP
	FX9YCIaaKwGAvJzYJhpbdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729625439; x=
	1729711839; bh=Zye2GdwIvJkPNjXAQSWrqToem6eNUlfkvWe1pGHqEu0=; b=e
	mMiLokaryWE/nSBi9L7SVjY15bNgY4Dr4prkNKHJsxUKiQsv0wsGHcTPZWLg9/MM
	7X7IZvr/FBcRs2T69nCMJrcWykzYuSXolxKUVXo9vrR7mx7OeBkSJr4GVBAzDU57
	K/Q2yNzHkHxurnWnOOaithnyZh13H0cw1HX+lGZggtbSurxwYavtX8GknXnFq294
	TP9IrLFkeRvQJqGC+ZB4/uXC78Yq1a7TMQ6OhOi6NEwUs7rCx4Jhh9uBJD5/gHuc
	Tw/aYCTVgkQ474hIdz1xsHMVbddg7DYw/ukWPFH9po1NexfVqG6CwzqvG3SfE297
	HoEqkvSTslQ9Mt+fFg0wA==
X-ME-Sender: <xms:X_0XZ4ctZjqP7MmRnfXzzmXPn04Q_U7JLJ_yqe2gZcmyAhsGg2JW5g>
    <xme:X_0XZ6PI0vwWCiJYrBigtHWCb3Bb6qX0SSxOjlpbkjMvI6ewsdmZY5LjtbwFs8eSu
    f7YgFkP5VPzxl-JyTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeihedgudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdforghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvg
    hnohhvohesshhquhgvsggsrdgtrgeqnecuggftrfgrthhtvghrnhephfevkeejueeukeef
    hfelleejheeuudfgteffvdetkeffjeduleffvdejkeefhedvnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhv
    ohesshhquhgvsggsrdgtrgdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepihhlphhordhjrghrvhhinhgvnheslhhinhhugidrihhnthgvlhdr
    tghomhdprhgtphhtthhopehhuggvghhovgguvgesrhgvughhrghtrdgtohhmpdhrtghpth
    htoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepphhlrghtfhhorhhmqdgurhhivhgvrhdqgiekieesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:X_0XZ5g3pk3lQ_a3p5XRYwf_V9zJ4u3wT3Bpqu__OPBBvXBy0mtwng>
    <xmx:X_0XZ9-nu7pzJ0_1_-gY0f9zOskP_bHir-Q1ir_I6ShVmP-fWS-MPg>
    <xmx:X_0XZ0uYkHorNsG0rmTJS5D9FEGfYuZdtHiwNo9-b6tcO9b4D6RnXg>
    <xmx:X_0XZ0HWbgjvHHj49oKYAt5JH8rbIIAN317KsXTr0kcu03I2ZctdEQ>
    <xmx:X_0XZwJjaSljeqYJCzJ16Gd3f5VBv2sgWBcGjINgkPLKB7wQZUiIr4J5>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3978A3C0066; Tue, 22 Oct 2024 15:30:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 22 Oct 2024 15:30:02 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Hans de Goede" <hdegoede@redhat.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Message-Id: <26b3d2dc-5a3e-46dd-8321-a04ba25dbf4f@app.fastmail.com>
In-Reply-To: <3635398e-f810-c42b-9c6e-f9e0bb19e298@linux.intel.com>
References: <mpearson-lenovo@squebb.ca>
 <20241021193837.7641-1-mpearson-lenovo@squebb.ca>
 <20241021193837.7641-4-mpearson-lenovo@squebb.ca>
 <3635398e-f810-c42b-9c6e-f9e0bb19e298@linux.intel.com>
Subject: Re: [PATCH 4/4] platform/x86: think-lmi: Multi-certificate support
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ilpo,

Thanks for the review.

On Tue, Oct 22, 2024, at 4:14 AM, Ilpo J=C3=A4rvinen wrote:
> On Mon, 21 Oct 2024, Mark Pearson wrote:
>
>> Lenovo are adding support for both Admin and System certificates to
>> the certificate based authentication feature
>>=20
>> This commit adds the support for this.
>>=20
>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> ---
>>  .../testing/sysfs-class-firmware-attributes   |   1 +
>>  drivers/platform/x86/think-lmi.c              | 141 ++++++++++++++--=
--
>>  drivers/platform/x86/think-lmi.h              |   4 +
>>  3 files changed, 116 insertions(+), 30 deletions(-)
>>=20
>> diff --git a/Documentation/ABI/testing/sysfs-class-firmware-attribute=
s b/Documentation/ABI/testing/sysfs-class-firmware-attributes
>> index 1a8b59f5d6e3..2713efa509b4 100644
>> --- a/Documentation/ABI/testing/sysfs-class-firmware-attributes
>> +++ b/Documentation/ABI/testing/sysfs-class-firmware-attributes
>> @@ -303,6 +303,7 @@ Description:
>>  					being configured allowing anyone to make changes.
>>  					After any of these operations the system must reboot for the ch=
anges to
>>  					take effect.
>> +					Admin and System certificates are supported from 2025 systems o=
nward.
>> =20
>>  		certificate_thumbprint:
>>  					Read only attribute used to display the MD5, SHA1 and SHA256 th=
umbprints
>> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/=
think-lmi.c
>> index 751e351dfc42..fca190232c24 100644
>> --- a/drivers/platform/x86/think-lmi.c
>> +++ b/drivers/platform/x86/think-lmi.c
>> @@ -169,11 +169,12 @@ MODULE_PARM_DESC(debug_support, "Enable debug c=
ommand support");
>>   */
>>  #define LENOVO_CERT_THUMBPRINT_GUID "C59119ED-1C0D-4806-A8E9-59AA318=
176C4"
>> =20
>> -#define TLMI_POP_PWD BIT(0) /* Supervisor */
>> -#define TLMI_PAP_PWD BIT(1) /* Power-on */
>> -#define TLMI_HDD_PWD BIT(2) /* HDD/NVME */
>> -#define TLMI_SMP_PWD BIT(6) /* System Management */
>> -#define TLMI_CERT    BIT(7) /* Certificate Based */
>> +#define TLMI_POP_PWD  BIT(0) /* Supervisor */
>> +#define TLMI_PAP_PWD  BIT(1) /* Power-on */
>> +#define TLMI_HDD_PWD  BIT(2) /* HDD/NVME */
>> +#define TLMI_SMP_PWD  BIT(6) /* System Management */
>> +#define TLMI_CERT_SVC BIT(7) /* Admin Certificate Based */
>> +#define TLMI_CERT_SMC BIT(8) /* System Certificate Based */
>> =20
>>  static const struct tlmi_err_codes tlmi_errs[] =3D {
>>  	{"Success", 0},
>> @@ -678,18 +679,35 @@ static ssize_t cert_thumbprint(char *buf, const=
 char *arg, int count)
>>  	return count;
>>  }
>> =20
>> +#define NUM_THUMBTYPES 3
>> +static char *thumbtypes[NUM_THUMBTYPES] =3D {"Md5", "Sha1", "Sha256"=
};
>> +
>>  static ssize_t certificate_thumbprint_show(struct kobject *kobj, str=
uct kobj_attribute *attr,
>>  			 char *buf)
>>  {
>>  	struct tlmi_pwd_setting *setting =3D to_tlmi_pwd_setting(kobj);
>> -	int count =3D 0;
>> +	char *wmistr;
>> +	int count =3D 0, i;
>
> Reverse xmas-tree order.

Ack

>
>> =20
>>  	if (!tlmi_priv.certificate_support || !setting->cert_installed)
>>  		return -EOPNOTSUPP;
>> =20
>> -	count +=3D cert_thumbprint(buf, "Md5", count);
>> -	count +=3D cert_thumbprint(buf, "Sha1", count);
>> -	count +=3D cert_thumbprint(buf, "Sha256", count);
>> +	for (i =3D 0; i < NUM_THUMBTYPES; i++) {
>
> Use ARRAY_SIZE() + add include for it.
>
> These days, the usual custom is to use unsigned int for loop variables=20
> that are never meant to be negative.
>
Will update.

>> +		if (tlmi_priv.pwdcfg.core.password_mode >=3D TLMI_PWDCFG_MODE_MULT=
ICERT) {
>> +			/* Format: 'SVC | SMC, Thumbtype' */
>> +			wmistr =3D kasprintf(GFP_KERNEL, "%s,%s",
>> +					   setting =3D=3D tlmi_priv.pwd_admin ? "SVC" : "SMC",
>> +					   thumbtypes[i]);
>> +		} else {
>> +			/* Format: 'Thumbtype' */
>> +			wmistr =3D kasprintf(GFP_KERNEL, "%s", thumbtypes[i]);
>> +		}
>> +		if (!wmistr)
>> +			return -ENOMEM;
>> +		count +=3D cert_thumbprint(buf, wmistr, count);
>> +		kfree(wmistr);
>> +	}
>> +
>>  	return count;
>>  }
>> =20
>> @@ -720,8 +738,15 @@ static ssize_t cert_to_password_store(struct kob=
ject *kobj,
>>  	if (!passwd)
>>  		return -ENOMEM;
>> =20
>> -	/* Format: 'Password,Signature' */
>> -	auth_str =3D kasprintf(GFP_KERNEL, "%s,%s", passwd, setting->signat=
ure);
>> +	if (tlmi_priv.pwdcfg.core.password_mode >=3D TLMI_PWDCFG_MODE_MULTI=
CERT) {
>> +		/* Format: 'SVC | SMC, password, signature' */
>> +		auth_str =3D kasprintf(GFP_KERNEL, "%s,%s,%s",
>> +				     setting =3D=3D tlmi_priv.pwd_admin ? "SVC" : "SMC",
>> +				     passwd, setting->signature);
>> +	} else {
>> +		/* Format: 'Password,Signature' */
>> +		auth_str =3D kasprintf(GFP_KERNEL, "%s,%s", passwd, setting->signa=
ture);
>> +	}
>>  	if (!auth_str) {
>>  		kfree_sensitive(passwd);
>>  		return -ENOMEM;
>> @@ -735,12 +760,19 @@ static ssize_t cert_to_password_store(struct ko=
bject *kobj,
>> =20
>>  static struct kobj_attribute auth_cert_to_password =3D __ATTR_WO(cer=
t_to_password);
>> =20
>> +enum cert_install_mode {
>> +	TLMI_CERT_INSTALL,
>> +	TLMI_CERT_UPDATE,
>> +};
>> +
>>  static ssize_t certificate_store(struct kobject *kobj,
>>  				  struct kobj_attribute *attr,
>>  				  const char *buf, size_t count)
>>  {
>>  	struct tlmi_pwd_setting *setting =3D to_tlmi_pwd_setting(kobj);
>> +	enum cert_install_mode install_mode =3D TLMI_CERT_INSTALL;
>>  	char *auth_str, *new_cert;
>> +	char *signature;
>>  	char *guid;
>>  	int ret;
>> =20
>> @@ -756,10 +788,18 @@ static ssize_t certificate_store(struct kobject=
 *kobj,
>>  		if (!setting->signature || !setting->signature[0])
>>  			return -EACCES;
>> =20
>> -		/* Format: 'serial#, signature' */
>> -		auth_str =3D kasprintf(GFP_KERNEL, "%s,%s",
>> -				dmi_get_system_info(DMI_PRODUCT_SERIAL),
>> -				setting->signature);
>> +		if (tlmi_priv.pwdcfg.core.password_mode >=3D TLMI_PWDCFG_MODE_MULT=
ICERT) {
>> +			/* Format: 'SVC | SMC, serial#, signature' */
>> +			auth_str =3D kasprintf(GFP_KERNEL, "%s,%s,%s",
>> +					     setting =3D=3D tlmi_priv.pwd_admin ? "SVC" : "SMC",
>> +					     dmi_get_system_info(DMI_PRODUCT_SERIAL),
>> +					     setting->signature);
>> +		} else {
>> +			/* Format: 'serial#, signature' */
>> +			auth_str =3D kasprintf(GFP_KERNEL, "%s,%s",
>> +					     dmi_get_system_info(DMI_PRODUCT_SERIAL),
>> +					     setting->signature);
>> +		}
>>  		if (!auth_str)
>>  			return -ENOMEM;
>> =20
>> @@ -776,24 +816,59 @@ static ssize_t certificate_store(struct kobject=
 *kobj,
>> =20
>>  	if (setting->cert_installed) {
>>  		/* Certificate is installed so this is an update */
>> -		if (!setting->signature || !setting->signature[0]) {
>> +		install_mode =3D TLMI_CERT_UPDATE;
>> +		/* If admin account enabled - need to use it's signature */
>> +		if (tlmi_priv.pwd_admin->pwd_enabled)
>> +			signature =3D tlmi_priv.pwd_admin->signature;
>> +		else
>> +			signature =3D setting->signature;
>> +	} else { /* Cert install */
>> +		/* Check if SMC and SVC already installed */
>> +		if ((setting =3D=3D tlmi_priv.pwd_system) && tlmi_priv.pwd_admin->=
cert_installed) {
>> +			/* This gets treated as a cert update */
>> +			install_mode =3D TLMI_CERT_UPDATE;
>> +			signature =3D tlmi_priv.pwd_admin->signature;
>> +		} else { /* Regular cert install */
>> +			install_mode =3D TLMI_CERT_INSTALL;
>> +			signature =3D setting->signature;
>> +		}
>> +	}
>> +
>> +	if (install_mode =3D=3D TLMI_CERT_UPDATE) {
>> +		/* This is a certificate update */
>> +		if (!signature || !signature[0]) {
>>  			kfree(new_cert);
>>  			return -EACCES;
>>  		}
>>  		guid =3D LENOVO_UPDATE_BIOS_CERT_GUID;
>> -		/* Format: 'Certificate,Signature' */
>> -		auth_str =3D kasprintf(GFP_KERNEL, "%s,%s",
>> -				new_cert, setting->signature);
>> +		if (tlmi_priv.pwdcfg.core.password_mode >=3D TLMI_PWDCFG_MODE_MULT=
ICERT) {
>> +			/* Format: 'SVC | SMC, certificate, signature' */
>> +			auth_str =3D kasprintf(GFP_KERNEL, "%s,%s,%s",
>> +					     setting =3D=3D tlmi_priv.pwd_admin ? "SVC" : "SMC",
>> +					     new_cert, signature);
>> +		} else {
>> +			/* Format: 'Certificate,Signature' */
>> +			auth_str =3D kasprintf(GFP_KERNEL, "%s,%s",
>> +					     new_cert, signature);
>> +		}
>>  	} else {
>>  		/* This is a fresh install */
>> -		if (!setting->pwd_enabled || !setting->password[0]) {
>> +		/* To set admin cert, a password must be enabled */
>> +		if ((setting =3D=3D tlmi_priv.pwd_admin) &&
>> +		    (!setting->pwd_enabled || !setting->password[0])) {
>>  			kfree(new_cert);
>>  			return -EACCES;
>>  		}
>>  		guid =3D LENOVO_SET_BIOS_CERT_GUID;
>> -		/* Format: 'Certificate,Admin-password' */
>> -		auth_str =3D kasprintf(GFP_KERNEL, "%s,%s",
>> -				new_cert, setting->password);
>> +		if (tlmi_priv.pwdcfg.core.password_mode >=3D TLMI_PWDCFG_MODE_MULT=
ICERT) {
>> +			/* Format: 'SVC | SMC, Certificate, password' */
>> +			auth_str =3D kasprintf(GFP_KERNEL, "%s,%s,%s",
>> +					     setting =3D=3D tlmi_priv.pwd_admin ? "SVC" : "SMC",
>> +					     new_cert, setting->password);
>> +		} else {
>> +			/* Format: 'Certificate, password' */
>> +			auth_str =3D kasprintf(GFP_KERNEL, "%s,%s", new_cert, setting->pa=
ssword);
>> +		}
>
> Have you considered creating a helper for this if/else construct to cr=
eate=20
> the string? (you've basically repeated it multiple times by now with=20
> limited change to only parameters AFAICT).
>

I hadn't considered it, but yeah, it probably makes sense.
Not completely sure how I would do it to be honest - if you've got any s=
uggestions let me know, but I will look into it and see if I can improve=
 it.

>>  	}
>>  	kfree(new_cert);
>>  	if (!auth_str)
>> @@ -873,14 +948,19 @@ static umode_t auth_attr_is_visible(struct kobj=
ect *kobj,
>>  		return 0;
>>  	}
>> =20
>> -	/* We only display certificates on Admin account, if supported */
>> +	/* We only display certificates, if supported */
>>  	if (attr =3D=3D &auth_certificate.attr ||
>>  	    attr =3D=3D &auth_signature.attr ||
>>  	    attr =3D=3D &auth_save_signature.attr ||
>>  	    attr =3D=3D &auth_cert_thumb.attr ||
>>  	    attr =3D=3D &auth_cert_to_password.attr) {
>> -		if ((setting =3D=3D tlmi_priv.pwd_admin) && tlmi_priv.certificate_=
support)
>> +		if (tlmi_priv.certificate_support) {
>> +			if (setting =3D=3D tlmi_priv.pwd_admin)
>
> These two if()s combined look the same as the old ode, why are you red=
oing=20
> it?

My indenting here is somehow messed up...not sure how that happened (wil=
l fix).
The block below should be indented too...and then I think it makes more =
sense.
Let me know if you disagree.

>
>> +				return attr->mode;
>> +		if ((tlmi_priv.pwdcfg.core.password_mode >=3D TLMI_PWDCFG_MODE_MUL=
TICERT) &&
>> +		    (setting =3D=3D tlmi_priv.pwd_system))
>>  			return attr->mode;
>> +		}
>>  		return 0;
>>  	}
>> =20
>> @@ -1700,12 +1780,13 @@ static int tlmi_analyze(void)
>>  		}
>>  	}
>> =20
>> -	if (tlmi_priv.certificate_support &&
>> -		(tlmi_priv.pwdcfg.core.password_state & TLMI_CERT))
>> -		tlmi_priv.pwd_admin->cert_installed =3D true;
>> -
>> +	if (tlmi_priv.certificate_support) {
>> +		tlmi_priv.pwd_admin->cert_installed =3D
>> +			tlmi_priv.pwdcfg.core.password_state & TLMI_CERT_SVC;
>> +		tlmi_priv.pwd_system->cert_installed =3D
>> +			tlmi_priv.pwdcfg.core.password_state & TLMI_CERT_SMC;
>> +	}
>>  	return 0;
>> -
>
> Stray change.

Oops. Will fix.

>
> --=20
>  i.
>
>>  fail_clear_attr:
>>  	for (i =3D 0; i < TLMI_SETTINGS_COUNT; ++i) {
>>  		if (tlmi_priv.setting[i]) {
>> diff --git a/drivers/platform/x86/think-lmi.h b/drivers/platform/x86/=
think-lmi.h
>> index 4728f40143a3..f267d8b46957 100644
>> --- a/drivers/platform/x86/think-lmi.h
>> +++ b/drivers/platform/x86/think-lmi.h
>> @@ -41,6 +41,10 @@ enum save_mode {
>>  };
>> =20
>>  /* password configuration details */
>> +#define TLMI_PWDCFG_MODE_LEGACY    0
>> +#define TLMI_PWDCFG_MODE_PASSWORD  1
>> +#define TLMI_PWDCFG_MODE_MULTICERT 3
>> +
>>  struct tlmi_pwdcfg_core {
>>  	uint32_t password_mode;
>>  	uint32_t password_state;
>>

Mark

